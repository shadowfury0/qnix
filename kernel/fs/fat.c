#include "types.h"
#include "mmu.h"
#include "ide.h"
#include "fat.h"

extern struct ide_device ide_devices[IDE_DEV_SIZE];

// switch to disk sectsize
#define SWT_BLOCK(x,bp) ((x * bp) / SECTSIZE)

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

// file in fat offset
uint
fat_clus_offset(struct fat_dir* dir,const char* name)
{
    char ch = dir->name[0];
    if (ch == 0x00 || ch == 0xe5)
        // free
        return 0;
    else if (ch == 0x20)
        // error
        return -1;

    if(!strncmp(dir->name,name,11)) {
        return  (dir->first_clus_low | (dir->first_clus_high << 16));
    }
    // not found 
    return  0;
}

// find filename in fat directory
void
fat_read_dir(uint* vs,const char* name)
{
    // struct  fat_dir* s;
    // struct  fat_dir* e = s + f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector / sizeof(struct fat_dir);
    // for (s = (struct fat_dir*)vs; s < e; s++)
    // {
    //     if (fat_clus_offset(s,name) > 0) break;
    // }
}

void
fat_read_block(struct fat_info* f,char* buf,uint offset)
{
    DEVICE_NFOUND_V(ideread(buf,offset,f->index,1));
}

// s is read size
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

// rszie is root directory size
void
fat_root_directory(struct fat_info* f,char* buf)
{
    uint sf = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    fat_read_blocks(f,buf,sf,PGROUNDUP(f->fat_size*f->bpb.bytes_per_sector));
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