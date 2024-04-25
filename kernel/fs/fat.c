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
    struct  fat_dir* e = (struct fat_dir*)((uint)s + PGROUNDUP(f->dir_sectors*f->bpb.bytes_per_sector));
    
    uint c = 0;
    for (;s<e;s++) {
        c=fat_clus_offset(s);
        if (!c) continue;
        // compare name
        if(!strncmp(s->name,name,11)) break;
    }
    return c;
}

// update current directory file info
void
fat_update_dir(struct fat_info* f,uint* dir,struct fat_dir* file)
{
    volatile struct  fat_dir* s = (struct fat_dir*)dir;
    struct  fat_dir* e = (struct fat_dir*)((uint)s + PGROUNDUP(f->dir_sectors*f->bpb.bytes_per_sector));
    
    for (;s<e;s++) {
        // compare name
        if(!strncmp(s->name,file->name,11)) {
            s->write_time = file->write_time;
            s->write_date = file->write_date;
            s->last_acc_date = file->last_acc_date;
            return;
        }
    }
    vprintf("file not found to update\n");
}

// dst is directory address 
// fs is file size
// return cluster offset
uint
fat16_clus_create(struct fat_info* f,void* dst,uint fs)
{
    volatile ushort* s = (ushort*)dst;
    ushort* e = (uint)s + f->fat_size * f->bpb.bytes_per_sector;
    uint cs = f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;
    uint size = (fs / cs) + (fs % cs ? 1 : 0);

    uint i = 0;
    uint j = 0;
    for (;s<e;s++,j++) 
    {
        if (i == size) break;
        if (*s == 0) i++;
    }

    uint offset = j-1;
    // is full not space to allocate
    if (i != size) return 0; 
    *--s = EOC_16;

    for (;i>0&&j>0&&s>dst;s--,j--)
        if (*s == 0) {
            *s = j + 1;
            i--;
        }
    return offset;
}

// if exist next cluster
uint
fat16_clus_next(ushort* fat,uint offset)
{
    return  fat[offset] == EOC_16 ? 0: (ushort)fat[offset];
}

// buf push read data size is caculate by file->file_size
void
fat_read_file(struct fat_info* f,uint* dir,struct fat_dir* file,void* buf)
{
    uint offset = 0;
    if (!(offset = fat_find_name(f,dir,file->name)))
    {
        vprintf("read file not found\n");
        return;
    }
    // cause root minus 1
    uint d = f->first_data_sector + offset - 1;
    uint r = SWT_BLOCK(d,f->bpb.bytes_per_sector);
    uint size = PGROUNDUP(file->file_size);
    fat_read_blocks(f,buf,r,size);
}

// dst is write file block destination
// block is the data sector
void
fat_write_file(struct fat_info* f,uint* dir,struct fat_dir* file,const char* buf,uint len)
{
    uint offset = 0;
    if (!(offset = fat_find_name(f,dir,file->name)))
    {
        vprintf("write file not found\n");
        return;
    }
    file->write_time = (ushort)(rtc_get_hour() << 11) | (rtc_get_minute() << 5) | rtc_get_second();
    file->write_date = (ushort)((rtc_get_year() - FAT16_DOS_YEAR )<< 9)  | (rtc_get_month() << 5)  | rtc_get_day();
    file->last_acc_date = (ushort)((rtc_get_year() - FAT16_DOS_YEAR )<< 9)  | (rtc_get_month() << 5)  | rtc_get_day();
    fat_update_dir(f,dir,file);
    // cause root minus 1
    uint d = f->first_data_sector + offset - 1;
    uint w = SWT_BLOCK(d,f->bpb.bytes_per_sector);
    uint size = PGROUNDUP(file->file_size);
    char* p = kalloc(size);
    fat_read_blocks(f,p,w,size);
    // maybe not efficiency
    memcpy(p,buf,len);
    fat_write_blocks(f,p,w,size);
    
    kfree(p,size);
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

// create file or directory in directory
void
fat_create_file(struct fat_info* f,void* fat,void* dir,struct fat_dir* file)
{
    struct fat_dir* start = (struct fat_dir*)dir;
    struct fat_dir* end = (uint)start + f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;

    uint val;
    for (;start<end;start++)
    {
        val = *(uint*)start;
        if (val && !strncmp(start->name,file->name,11))
        {
            vprintf("file or directory is exist\n");
            break;
        }
        else if (!val) {
            // write into fat1 fat2  
            if (f->fat_type == FAT12)
            {
            }
            else if (f->fat_type == FAT16)
            {
                if(!(file->first_clus_low = fat16_clus_create(f,fat,file->file_size)))
                    vprintf("cluster is full\n");
                else
                {
                    memcpy(start,file,sizeof(struct fat_dir));
                    start->crt_time = (rtc_get_hour() << 11) | (rtc_get_minute() << 5) | rtc_get_second();
                    start->crt_date = ((rtc_get_year() - FAT16_DOS_YEAR )<< 9)  | (rtc_get_month() << 5)  | rtc_get_day();
                    start->last_acc_date = start->crt_date;
                    start->first_clus_high = 0;
                }
            }
            else if (f->fat_type == FAT32) 
            {
            }
            break;
        }
    }

}

// test
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
    char buf[100] = "1111111111aaaaaaaaaaaaa21390123801209a@@wqio";
    fat_write_file(f,dp,dir,buf,100);

    fat_write_blocks(f,dp,root,dsize);
    fat_write_blocks(f,fp,fat1,fsize);
    fat_write_blocks(f,fp,fat2,fsize);

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