#include "types.h"
#include "ide.h"
#include "fat.h"

extern struct ide_device ide_devices[4];

// switch to disk sectsize
#define SWT_SECTSIZE(x,bp) ((x * bp) / SECTSIZE)

struct  fat_bpb fat_boot;

// base fat info
struct fat_info {
    uchar   exist;
    uchar   fat_type;
    uint    total_sectors;
    uint    total_clusters;
    uint    first_fat_sector;
    uint    second_fat_sector;
    uint    fat_size;
    uint    first_root_sector;
    uint    dir_sectors;
    uint    first_data_sector;
    uint    data_sectors;
} fat_info[IDE_DEV_SIZE];

void
fat_init(void)
{
    uint i=0;
    for (i=0;i<IDE_DEV_SIZE;i++)
    {
        fat_info[i].exist = 0;
        fat_info[i].fat_type = 0;
    }
}

// init ide_device[i]
void
fat_alloc(uint index)
{
    if (index >= IDE_DEV_SIZE)
    {
        vprintf("device is not found\n");
        return;
    }
    else if (!ide_devices[index].exist) {
        vprintf("do not exist\n");
        return;
    }

    char* p = alloc_page();
    fat_info[index].exist = 1;    
    // read first bpb block
    ideread(p,0,index,1);
    memcpy(&fat_boot,p,sizeof(struct fat_bpb));
    // Total sectors in volume (including VBR):
    fat_info[index].total_sectors = 
    (fat_boot.total_sectors_16 == 0)? fat_boot.total_sectors_32 : fat_boot.total_sectors_16;
    
    // FAT size in sectors:
    fat_info[index].fat_size = (fat_boot.fats_size_16 == 0)? 
    fat_boot.ext_32.fat_size_32 : fat_boot.fats_size_16;

    // The first sector in the File Allocation Table
    fat_info[index].first_fat_sector = fat_boot.reserved_sector_count;
    fat_info[index].second_fat_sector = fat_boot.reserved_sector_count + fat_info[index].fat_size;

    // The first root directory sector
    fat_info[index].first_root_sector = 
    fat_boot.reserved_sector_count + (fat_boot.nums_fat * fat_info[index].fat_size);
    // The size of the root directory (unless you have FAT32, in which case the size will be 0):
    fat_info[index].dir_sectors = 
    ((fat_boot.root_entry_count * sizeof(struct fat_dir)) + (fat_boot.bytes_per_sector - 1)) / fat_boot.bytes_per_sector;
    // The first data sector
    fat_info[index].first_data_sector = 
    fat_info[index].first_root_sector + fat_info[index].dir_sectors;

    // The total number of data sectors
    fat_info[index].data_sectors = 
    fat_info[index].total_sectors - (fat_boot.reserved_sector_count + (fat_boot.nums_fat * fat_info[index].fat_size) + fat_info[index].dir_sectors);
    // The total number of clusters
    fat_info[index].total_clusters = fat_info[index].data_sectors / fat_boot.sectors_per_cluster;
    // The FAT type of this file system:
    if (fat_boot.bytes_per_sector == 0) 
        fat_info[index].fat_type = ExFAT;
    else if(fat_info[index].total_clusters < FAT12_CLUST) 
        fat_info[index].fat_type = FAT12;
    else if(fat_info[index].total_clusters < FAT16_CLUST) 
        fat_info[index].fat_type = FAT16;
    else
        fat_info[index].fat_type = FAT32;

    free_page(p);
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
    struct  fat_dir* s;
    struct  fat_dir* e = s + fat_boot.sectors_per_cluster * fat_boot.bytes_per_sector / sizeof(struct fat_dir);
    for (s = (struct fat_dir*)vs; s < e; s++)
    {
        if (fat_clus_offset(s,name) > 0) break;
    }
}

void
fat_root_directory(struct fat_info* f)
{
    // uint sf = SWT_SECTSIZE(f->first_fat_sector,fat_boot.bytes_per_sector);
    // uint count = SWT_SECTSIZE(f->fat_size,fat_boot.bytes_per_sector);
    // char* p = alloc_page();
    // ideread(p,sf,1,count);
    // free_page(p);
    // uint sf = SWT_SECTSIZE(f->first_fat_sector,fat_boot.bytes_per_sector);
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