#include "types.h"
#include "ide.h"
#include "fat.h"

extern struct ide_device ide_devices[4];

// Official reference, not necessarily standard
// disk size to sector per cluster
// struct ds_to_spc {
//     // up to disk size
//     u32     disk_size;
//     // sector per cluster value
//     u8      val; // KB
// };
// static struct ds_to_spc disk_table16[] = {
//     // if less than 16MB maybe is 2k cluster
//     { 8400, 0},         /* disks up to 4.1 MB, the 0 value for SecPerClusVal trips an error */
//     { 32680, 2},        /* disks up to 16 MB, 1k cluster */
//     { 262144, 4},       /* disks up to 128 MB, 2k cluster */
//     { 524288, 8},       /* disks up to 256 MB, 4k cluster */
//     { 1048576, 16},     /* disks up to 512 MB, 8k cluster */
//     /* The entries after this point are not used unless FAT16 is forced */
//     { 2097152, 32},     /* disks up to 1 GB, 16k cluster */
//     { 4194304, 64},     /* disks up to 2 GB, 32k cluster */
//     { 0xFFFFFFFF, 0}    /* any disk greater than 2GB, 0 value for SecPerClusVal trips an error */
// };
// static struct ds_to_spc disk_table32[] = {
//     { 66600, 0},        /* disks up to 32.5 MB, the 0 value for SecPerClusVal trips an error */
//     { 532480, 1},       /* disks up to 260 MB, .5k cluster */
//     { 16777216, 8},     /* disks up to 8 GB, 4k cluster */
//     { 33554432, 16},    /* disks up to 16 GB, 8k cluster */
//     { 67108864, 32},    /* disks up to 32 GB, 16k cluster */
//     { 0xFFFFFFFF, 64}   /* disks greater than 32GB, 32k cluster */
// };

struct fat_bpb fat_boot;

void
fat_init(void)
{
    char* p = kalloc();
    if (!ide_devices[2].exist) {
        vprintf("do not exist\n");
        return;
    }

    // read first bpb block
    ideread(p,0,2);

    memcpy(&fat_boot,p,sizeof(struct fat_bpb));

    fat_info();

}

void
fat_info(void)
{
    // Total sectors in volume (including VBR):
    uint total_sectors = 
    (fat_boot.total_sectors_16 == 0)? fat_boot.total_sectors_32 : fat_boot.total_sectors_16;

    // FAT size in sectors:
    uint fat_size = (fat_boot.fats_size_16 == 0)? 
    fat_boot.ext_32.fat_size_32 : fat_boot.fats_size_16;

    // The size of the root directory (unless you have FAT32, in which case the size will be 0):
    uint root_dir_sectors = 
    ((fat_boot.root_entry_count * sizeof(struct fat_dir)) + (fat_boot.bytes_per_sector - 1)) / fat_boot.bytes_per_sector;

    // The first data sector
    uint first_data_sector = 
    fat_boot.reserved_sector_count + (fat_boot.nums_fat * fat_size) + root_dir_sectors;

    // The first sector in the File Allocation Table
    uint first_fat_sector = fat_boot.reserved_sector_count;

    // The total number of data sectors
    uint data_sectors = 
    total_sectors - (fat_boot.reserved_sector_count + (fat_boot.nums_fat * fat_size) + root_dir_sectors);

    // The total number of clusters
    uint total_clusters = data_sectors / fat_boot.sectors_per_cluster;

    uint fat_type;
    // The FAT type of this file system:
    if (fat_boot.bytes_per_sector == 0) 
    {
        fat_type = ExFAT;
    }
    else if(total_clusters < FAT12_CLUST) 
    {
        fat_type = FAT12;
    } 
    else if(total_clusters < FAT16_CLUST) 
    {
        fat_type = FAT16;
    } 
    else
    {
        fat_type = FAT32;
    }

    // ThisFATSecNum = fat_boot.reserved_sector_count + (offset / fat_boot.bytes_per_sector);
    // ThisFATEntOffset = REM(FATOffset / BPB_BytsPerSec);

    // is end of file
    // EOC value 0x0FFF for FAT12, 0xFFFF for FAT16, and 0x0FFFFFFF for FAT32 when they set the
    // IsEOF = FALSE;
    // if(FATType == FAT12) {
    //     if(FATContent >= 0x0FF8)
    //         IsEOF = TRUE;
    // } else if(FATType == FAT16) {
    //     if(FATContent >= 0xFFF8)
    //         IsEOF = TRUE;
    // } else if (FATType == FAT32) {
    //     if(FATContent >= 0x0FFFFFF8)
    //         IsEOF = TRUE;
    // }
    uint i;
    for (i=0;i<8;i++)
        info(fat_boot.ext_16.fat_type_label[i]);
}

void
read_fat(uint offset)
{
    // if (fat_type == FAT12)
    //     offset = N + (N / 2);
    // else if (fat_type == FAT16)
    //     offset = N * 2;
    // else if (fat_type == FAT32)
    //     offset = N * 4;
}

// file in fat offset
uint
fat_clus_offset(struct fat_dir* dir,const char* name)
{
    char ch = dir.name[0];
    if (ch == 0x00 || ch == 0xe5)
        // free
        return 0;
    else if (ch == 0x20)
        // error
        return -1;

    if(!strncmp(&dir.name,name,11)) {
        return  (dir.first_clus_low | (dir.first_clus_high << 16));
    }
    // not found 
    return  0;
}

// find filename in fat directory
void
fat_read_dir(uint* vs,const char* name)
{
    struct  fat_dir* s;
    struct  e = s + fat_boot.sectors_per_cluster * fat_boot.bytes_per_sector / sizeof(struct fat_dir);
    for (s = (struct fat_dir*)vs; s < e; s++)
    {
        // find it
        if (fat_clus_offset(s,name) > 0)
            break;
    }
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