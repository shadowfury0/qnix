// file system

#define     FS_FAT          1

struct inode {
    struct  inode* parent;
    struct  inode** child;
    char* name[256];
};

struct file_system {
    ushort    itype;        // file system type
    union {
        struct fat_info f;
    } u;
};