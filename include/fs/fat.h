// +------------------------+-------------+-------------------+----------------+--------------+
// | Boot Sector            |  Reserved   |  File Allocation  | Root Directory | Data Region  |
// | BIOS Parameter Block   |   Sectors   |       Table       |   Region       |              |
// +------------------------+-------------+-------------------+----------------+--------------+

// fat12 fat16
struct fat_ext_16 {
    u8      bios_drive_num;
    u8      reserved1;
    u8      boot_signature;
    u32     volume_id;
    u8      volume_label[11];
    u8      fat_type_label[8];
}__attribute__((packed));

// fat32
struct fat_ext_32 {
    u32     fat_size_32;                // This field is the FAT32 32-bit count of sectors occupied by ONE FAT.
    u16     extended_flags;
    u16     fat_version;
    u32     root_cluster;
    u16     fat_info;
    u16     backup_BS_sector;
    u8      reserved_0[12];
    u8      drive_number;
    u8      reserved1;
    u8      boot_signature;
    u32     volume_id;
    u8      volume_label[11];
    u8      fat_type_label[8];
}__attribute__((packed));

// (BIOS Parameter Block)
struct fat_bpb {
    u8      jmpboot[3];
    u8      oem_name[8];
    u16     bytes_per_sector;           // Count of bytes per sector 512, 1024, 2048 or 4096.
    u8      sectors_per_cluster;        // Number of sectors per allocation unit.
    // Number of reserved sectors in the Reserved region of the volume starting at the first sector of the volume.
    u16     reserved_sector_count;      
    u8      nums_fat;                   // The count of FAT data structures on the volume.
    // For FAT12 and FAT16 volumes, this field contains the count of 
    // 32-byte directory entries in the root directory. no use for fat32
    u16     root_entry_count;           
    u16     total_sectors_16;
    u8      media_type;                 // 0xF8
    u16     fats_size_16;               // This field is the FAT12/FAT16 16-bit count of sectors occupied by ONE FAT.
    u16     sectors_per_track;          // Sectors per track for interrupt 0x13
    u16     head_side_count;            // Number of heads for interrupt 0x13.
    u32     hidden_sector_count;        // Count of hidden sectors preceding the partition that contains this FAT volume.
    u32     total_sectors_32;               
// 36
    union {
        struct  fat_ext_16 ext_16;
        struct  fat_ext_32 ext_32;
    }
} __attribute__((packed));

struct fat_dir {
    u8      name[11];
    u8      attr;           // File attributes:
    u8      ntres;          // Reserved for use by Windows NT.
    u8      crt_time_tenth;      // This field actually contains a count of tenths of a second.
    u16     crt_time;       // Time file was created.      
    u16     crt_date;       // Date file was created.
    u16     last_acc_date;      // Last access date.
    // High word of this entry’s first cluster number (always 0 for a FAT12 or FAT16 volume).
    u16     first_clus_high;   
    u16     write_time;         // Time of last write.
    u16     write_date;         // Date of last write.
    u16     first_clus_low;     // Low word of this entry’s first cluster number.
    u32     file_size;          // 32-bit DWORD holding this file’s size in bytes.
};

struct fat_long_dir {
    // The order of this entry in the sequence of long dir entries 
    // associated with the short dir entry at the end of the long dir set.
    u8      order;         
    u8      name1[10];      // The first 5, 2-byte characters of this entry.         
    u8      attr;           // Attributes - must be ATTR_LONG_NAME
    u8      type;           // Long entry type. Zero for name entries.
    u8      check_sum;           // Checksum of name in the short dir entry at the end of the long dir set.
    u8      name2[12];      // The next 6, 2-byte characters of this entry.
    u16     first_clus_low;      // Must be zero
    u8      name3[4];      // 	The final 2, 2-byte characters of this entry.
};

#define     FAT12                   0x1
#define     FAT16                   0x2
#define     FAT32                   0x3
#define     ExFAT                   0x4

#define     FAT12_CLUST             4085
#define     FAT16_CLUST             65525

#define     LAST_LONG_ENTRY         0x40 

#define     ATTR_READ_ONLY          0x01 
#define     ATTR_HIDDEN             0x02 
#define     ATTR_SYSTEM             0x04 
#define     ATTR_VOLUME_ID          0x08 
#define     ATTR_DIRECTORY          0x10 
#define     ATTR_ARCHIVE            0x20 
#define     ATTR_LONG_NAME          (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID)
#define     ATTR_LONG_NAME_MASK     (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID | ATTR_DIRECTORY | ATTR_ARCHIVE)

// END OF CLUSTER
#define     EOC_12                  0x0fff
#define     EOC_16                  0xffff
#define     EOC_32                  0x0fffffff

// The “BAD CLUSTER” value is 0x0FF7 for FAT12, 0xFFF7 for FAT16, and 0x0FFFFFF7 for FAT32.