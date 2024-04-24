#include "types.h"
#include "mmu.h"
#include "ide.h"
#include "fat.h"

extern struct ide_device ide_devices[IDE_DEV_SIZE];

// switch to disk sectsize
#define SWT_BLOCK(x,bp) ((x * bp) / SECTSIZE)

// global pointer to cur fat

// init ide_device[i]
void
fat_init(struct fat_info* f)
{
    // read first bpb block
    char* p = alloc_page();
    DEVICE_NFOUND_V(ideread(p,0,f->index,1));
    memcpy(&f->bpb,p,sizeof(struct fat_bpb));
    free_page(p);
    // Total sectors in volume (including VBR):
    f->total_sectors = 
    (f->bpb.total_sectors_16 == 0)? f->bpb.total_sectors_32 : f->bpb.total_sectors_16;
    
    // FAT size in sectors:
    f->fat_size = (f->bpb.fats_size_16 == 0)? 
    f->bpb.ext_32.fat_size_32 : f->bpb.fats_size_16;

    // The first sector in the File Allocation Table
    f->first_fat_sector = f->bpb.reserved_sector_count;
    f->second_fat_sector = f->bpb.reserved_sector_count + f->fat_size;
    // The first root directory sector
    f->first_root_sector = 
    f->bpb.reserved_sector_count + (f->bpb.nums_fat * f->fat_size);
    // The size of the root directory (unless you have FAT32, in which case the size will be 0):
    f->dir_sectors = 
    ((f->bpb.root_entry_count * sizeof(struct fat_dir)) + (f->bpb.bytes_per_sector - 1)) / f->bpb.bytes_per_sector;
    // The first data sector
    f->first_data_sector = 
    f->first_root_sector + f->dir_sectors;

    // The total number of data sectors
    f->data_sectors = 
    f->total_sectors - (f->bpb.reserved_sector_count + (f->bpb.nums_fat * f->fat_size) + f->dir_sectors);
    // The total number of clusters
    f->total_clusters = f->data_sectors / f->bpb.sectors_per_cluster;
    // The FAT type of this file system:
    if (f->bpb.bytes_per_sector == 0) 
        f->fat_type = ExFAT;
    else if(f->total_clusters < FAT12_CLUST) 
        f->fat_type = FAT12;
    else if(f->total_clusters < FAT16_CLUST) 
        f->fat_type = FAT16;
    else
        f->fat_type = FAT32;
}

void
fat_read_block(struct fat_info* f,char* buf,uint offset)
{
    DEVICE_NFOUND_V(ideread(buf,offset,f->index,1));
}

void
fat_read_blocks(struct fat_info* f,char* buf,uint offset,uint s)
{
    DEVICE_NFOUND_V(ideread(buf,offset,f->index,s / SECTSIZE));
}

void
fat_write_block(struct fat_info* f,char* buf,uint offset)
{
    DEVICE_NFOUND_V(idewrite(buf,offset,f->index,1));
}

void
fat_write_blocks(struct fat_info* f,char* buf,uint offset,uint s)
{
    DEVICE_NFOUND_V(idewrite(buf,offset,f->index,s/SECTSIZE));
}

// dst is directory address 
// fs is file size
uint
fat16_clus_create(struct fat_info* f,void* dst,uint fs)
{
    volatile ushort* s = (ushort*)dst;
    ushort* e = (uint)s + f->fat_size * f->bpb.bytes_per_sector;
    uint cs = f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;
    uint size = (fs / cs) + (fs % cs ? 1 : 0);

    volatile uint i = 0;
    volatile uint j = 0;
    for (;s<e;s++,j++) 
    {
        if (i == size) break;
        if (*s == 0) i++;
    }

    // is full not space to allocate
    if (i != size) return 0; 
    *--s = EOC_16;

    for (;i>0&&j>0&&s>dst;s--,j--)
        if (*s == 0) {
            *s = j + 1;
            i--;
        }
    return 1;
}

// if exist next cluster
uint
fat16_clus_next(ushort* fat,uint offset)
{
    return  fat[offset] == EOC_16 ? 0: (ushort)fat[offset];
}

void
fat_rootdir_init(struct fat_info* f)
{
    // read root directory
    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    ushort* fp = kalloc(fsize);
    fat_read_blocks(f,fp,fat1,fsize);

    // root directory is null ?
    if (*(fp + 2) == 0) {
        if (f->fat_type == FAT16)
            fat16_clus_create(f,fp,f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector);
        fat_write_blocks(f,fp,fat1,fsize);
    // allocate all fat default two
        fat_write_blocks(f,fp,fat2,fsize);
    }
    kfree(fp,fsize);
}

// return fat cluster offset
uint
fat_clus_offset(struct fat_dir* dir)
{
    char ch = dir->name[0];
    if (ch == 0x00 || ch == 0xe5)
        // free
        return 0;
    else if (ch == 0x20)
        // error
        return -1;

    return  (dir->first_clus_low | (dir->first_clus_high << 16));
}

// find name in one cluster directory 
uint
fat_find_name(struct fat_info* f,uint* dir,const char* name)
{
    struct  fat_dir* s = (struct fat_dir*)dir;
    struct  fat_dir* e = s + f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector / sizeof(struct fat_dir);
    
    uint c = 0;
    for (;s<e;s++) {
        c=fat_clus_offset(s);
        if (c) continue;
        // compare name
        if(!strncmp(s->name,name,11)) break;
    }
    return c;
}

// create file or directory in directory
void
fat_create_file(struct fat_info* f,void* fat,void* dir,struct fat_dir* file)
{
    struct fat_dir* start = dir;
    struct fat_dir* end = (uint)start + f->bpb.root_entry_count * sizeof(struct fat_dir);

    for (;start<end;start++)
    {
        if (*(uint*)start == 0) {
            // write into fat1 fat2  
            if (f->fat_type == FAT12)
            {
            }
            else if (f->fat_type == FAT16)
            {
                if (!strncmp(start->name,file->name,11))
                    vprintf("file or directory is exist\n");
                else if(!fat16_clus_create(f,fat,file->file_size))
                    vprintf("cluster is full\n");
                memcpy(start,file,sizeof(struct fat_dir));
            }
            else if (f->fat_type == FAT32) 
            {
            }
            break;
        }
    }
}

// create
void
fat_test(struct fat_info* f,struct fat_dir* dir)
{
    // find directory file
    uint root = SWT_BLOCK(f->first_root_sector,f->bpb.bytes_per_sector);
    uint dsize = PGROUNDUP(f->dir_sectors*f->bpb.bytes_per_sector);
    char* dp = kalloc(dsize);
    fat_read_blocks(f,dp,root,dsize);

    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    char* fp = kalloc(fsize);
    fat_read_blocks(f,fp,fat1,fsize);

    fat_create_file(f,fp,dp,dir);


    fat_write_blocks(f,fp,fat1,fsize);
    fat_write_blocks(f,fp,fat2,fsize);
    fat_write_blocks(f,dp,root,dsize);

    kfree(dp,dsize);
    kfree(fp,fsize);
}

//-----------------------------------------------------------------------------
// checksum()
// Returns an unsigned byte checksum computed on an unsigned byte
// array:   The array must be 11 bytes long and is assumed to contain
//          a name stored in the format of a MS-DOS directory entry.
//          Passed: pFcbName Pointer to an unsigned byte array assumed to be
//          11 bytes long.
// Returns: Sum An 8-bit unsigned checksum of the array pointed
//          to by pFcbName.
//------------------------------------------------------------------------------
uchar 
checksum (uchar *pFcbName)
{
    short FcbNameLen;
    uchar Sum;
    Sum = 0;
    for (FcbNameLen=11; FcbNameLen!=0; FcbNameLen--) {
        // NOTE: The operation is an unsigned char rotate right
        Sum = ((Sum & 1) ? 0x80 : 0) + (Sum >> 1) + *pFcbName++;
    }
    return (Sum);
}