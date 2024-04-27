#define     FT_DIR          1
#define     FT_FILE         2

// file system
#define     FS_FAT          1


#define     FILE_NAME_SIZE  16
#define     CHLD_SIZE       256

// super information
struct  fs_info {
    // file system info type
    union {
        struct  fat_info  fat;
    } u[IDE_DEV_SIZE];
};


struct fnode {
    uchar       fst;            // File system type
    uchar       t;              // File type
    uchar       dev;            // Device number
    uint        size;           // Size of file (bytes)
    uint        block;          // Block offset in dev
    struct      fdir*    p;     // point to Dir
    char        name[FILE_NAME_SIZE];
};


struct  fdir {
    // first is current directory   (.)
    // second is parent directory   (..)
    struct      fnode    cur[CHLD_SIZE];         // sub directory or file
};
