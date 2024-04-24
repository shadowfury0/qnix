// file system

struct inode {
    uint  dtype;        // disk system type
    union {
        struct fat_info f;
    } u;
};