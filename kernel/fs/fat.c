#include "types.h"
#include "mmu.h"
#include "ide.h"
#include "fat.h"
#include "fs.h"

extern struct fs_info fs_info;
extern struct ide_device ide_devices[IDE_DEV_SIZE];

// switch to disk sectsize
#define SWT_BLOCK(x,bp) (((x) * (bp)) / SECTSIZE)
// data block to fat
#define DATB2FAT(f,n) (((n) - f->first_data_sector) / f->bpb.sectors_per_cluster + 2)
// fat to data block
#define FAT2DATB(f,n) ( ((n) - 2) * f->bpb.sectors_per_cluster + f->first_data_sector)

// global pointer to cur fat

// This directory is bound to the starting root directory of the device
void
fat_init(struct fdir* dir,uint n,const char* name)
{
    struct  fat_info* f = &fs_info.u[n].fat;
    // read first bpb block
    char* p = alloc_page();
    DEVICE_NFOUND_V(ideread(p,0,n,1));
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

    struct  fnode* d = &dir->cur[0];
    d->t = FT_DIR;
    d->fst = FS_FAT;
    d->dev = n;
    d->p = d;
    d->block = SWT_BLOCK(f->first_root_sector,f->bpb.bytes_per_sector);
    // root directory size
    d->size = f->bpb.root_entry_count*sizeof(struct fat_dir);
    strncpy(d->name,name,strlen(name));

    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    f->fp = kalloc(fsize);
    fs_read_blocks(f->fp,fat1,d->dev,fsize);
}

void
fat_clean(uint n)
{
    struct  fat_info* f = &fs_info.u[n].fat;
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    kfree(f->fp,fsize);
}

// // return fat cluster offset
// uint
// fat_clus_offset(struct fat_dir* dir)
// {
//     char ch = dir->name[0];
//     if (ch == 0x00 || ch == 0xe5)
//         // free
//         return 0;
//     else if (ch == 0x20)
//         // error
//         return -1;

//     return  (dir->first_clus_low | (dir->first_clus_high << 16));
// }

// // find name in one cluster directory return cluster offset
// uint
// fat_find_name(struct fat_info* f,uint* dir,const char* name)
// {
//     struct  fat_dir* s = (struct fat_dir*)dir;
//     struct  fat_dir* e = (struct fat_dir*)((uint)s + f->dir_sectors*f->bpb.bytes_per_sector);
    
//     uint c = 0;
//     for (;s<e;s++) {
//         c=fat_clus_offset(s);
//         if (!c) continue;
//         // compare name
//         if(!strncmp(s->name,name,11)) break;
//     }
//     return c;
// }

// // switch not root directory
// void
// fat_swtch_dir(struct fat_info* f,struct fat_dir* dir)
// {
//     if (f->rp != f->curdir)
//         kfree(f->curdir,PGROUNDUP(f->cursize));

//     if (!(dir->attr & ATTR_DIRECTORY)) {
//         vprintf("is not directory can not switch\n");
//         return;
//     } 
//     f->cursize = dir->file_size;
//     f->curdir = kalloc(PGROUNDUP(f->cursize));
// }

// // update current directory file info
// void
// fat_update_dir(struct fat_info* f,uint* dir,struct fat_dir* file)
// {
//     volatile struct  fat_dir* s = (struct fat_dir*)dir;
//     struct  fat_dir* e = (struct fat_dir*)((uint)s + PGROUNDUP(f->dir_sectors*f->bpb.bytes_per_sector));
    
//     for (;s<e;s++) {
//         // compare name
//         if(!strncmp(s->name,file->name,11)) {
//             s->write_time = file->write_time;
//             s->write_date = file->write_date;
//             s->last_acc_date = file->last_acc_date;
//             return;
//         }
//     }
// }

// dst is directory address 
// fs is file size
// return cluster offset
uint
fat16_clus_create(struct fat_info* f,uint fs)
{
    volatile ushort* s = (ushort*)f->fp;
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

    uint offset = j-2;
    // is full not space to allocate
    if (i != size) return 0; 
    *--s = EOC_16;

    for (;i>0&&j>0&&s>(ushort*)f->fp;s--,j--)
        if (*s == 0) {
            *s = j;
            i--;
        }
    return offset;
}

// // dst is write file block destination
// // block is the data sector
// void
// fat_clus_write_file(struct fat_info* f,uint* dir,struct fat_dir* file,const char* buf,uint len)
// {
//     uint offset = 0;
//     if (!(offset = fat_find_name(f,dir,file->name)))
//     {
//         vprintf("write file not found\n");
//         return;
//     }
//     file->write_time = (ushort)(rtc_get_hour() << 11) | (rtc_get_minute() << 5) | rtc_get_second();
//     file->write_date = (ushort)((rtc_get_year() - FAT16_DOS_YEAR) << 9)  | (rtc_get_month() << 5)  | rtc_get_day();
//     file->last_acc_date = (ushort)((rtc_get_year() - FAT16_DOS_YEAR) << 9)  | (rtc_get_month() << 5)  | rtc_get_day();
//     fat_update_dir(f,dir,file);
//     // cause root minus 1
//     uint d = f->first_data_sector + (offset - 2) * f->bpb.sectors_per_cluster;
//     uint w = SWT_BLOCK(d,f->bpb.bytes_per_sector);
//     uint cs = f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;

//     uint size = PGROUNDUP(file->file_size);
//     char* p = kalloc(size);
//     fs_read_blocks(f,p,w,cs);
//     // maybe not efficiency
//     memcpy(p,buf,len);
//     fs_write_blocks(f,p,w,cs);
    
//     kfree(p,size);
// }


// // list current dir all file or dir information
// void
// fat_dir_dump(struct fat_info* f,uint* dir)
// {
//     struct fat_dir* s = (struct fat_dir*)dir;
//     struct fat_dir* e = (uint)s + f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;

//     for (;s<e;s++)
//     {
//         if (*(uint*)s == 0) break;
//         vprintf("%x   %d  %s\n",s->attr,s->file_size,s->name);
//     }
// }

// create in current
void
fat_create(struct fdir* fd,const char* name,uint size,uint type)
{
    // current dir
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;
    // find directory file
    uint dsize = PGROUNDUP(f->bpb.root_entry_count*sizeof(struct fat_dir));
    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);

    uint  cs = dir->size;
    char* p = kalloc(PGROUNDUP(cs));
    struct fat_dir* start = p;
    fs_read_blocks(start,dir->block,dir->dev,cs);
    struct fat_dir* end = (uint)start + cs;

    uint val;
    for (;start<end;start++)
    {
        val = *(uint*)start;
        if (val && !strncmp(start->name,name,11))
        {
            vprintf("file or directory is exist\n");
            kfree(p,PGROUNDUP(cs));
            return ;
        }
        else if (!val) {
            // write into fat1 fat2  
            if (f->fat_type == FAT12)
            {
            }
            else if (f->fat_type == FAT16)
            {
                if(!(start->first_clus_low = fat16_clus_create(f,size)))
                {
                    vprintf("cluster is full\n");
                    kfree(p,PGROUNDUP(cs));
                    return;
                }
                else
                {
                    start->crt_time = (rtc_get_hour() << 11) | (rtc_get_minute() << 5) | rtc_get_second();
                    start->crt_date = ((rtc_get_year() - FAT16_DOS_YEAR )<< 9)  | (rtc_get_month() << 5)  | rtc_get_day();
                    start->last_acc_date = start->crt_date;
                    start->first_clus_high = 0;
                    start->file_size = size;
                    strncpy(start->name,name,11);
                }
            }
            else if (f->fat_type == FAT32) 
            {
            }
            break;
        }
    }

    fdir_create(fd,type,name,size,
    f->first_data_sector + SWT_BLOCK(start->first_clus_low - 2,f->bpb.bytes_per_sector * f->bpb.sectors_per_cluster));

    fs_write_blocks(p,dir->block,dir->dev,cs);
    fs_write_blocks(f->fp,fat1,dir->dev,fsize);
    fs_write_blocks(f->fp,fat2,dir->dev,fsize);

    kfree(p,PGROUNDUP(cs));
}

void
fat_write(struct fdir* fd,const char* name,char* buf,uint len)
{
    struct fnode* node = fdir_find(fd,name);
    if(!node)
    {
        vprintf("file or directory not found in write function  \n");
        return;
    }
    
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;

    uint  cs = node->size;
    uint  bs = f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;

    cs = PGROUNDUP(cs / (f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector)
    + (cs % (f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector) ? bs : 0));

    char* p = kalloc(cs);

    uint  i = node->block;
    char* bufstart = buf;
    while (i != EOC_16) {
        memset(p,0,cs);
        fs_read_blocks(p,i,dir->dev,cs);
        // copy data
        memcpy(p,bufstart,len);
        len -= bs;
        bufstart += bs;
        fs_write_blocks(p,i,dir->dev,cs);
        // find next cluster
        i = FAT16_NEXT(f->fp,DATB2FAT(f,i));
        if (i != EOC_16) i = FAT2DATB(f,i);
    }

    kfree(p,cs);
}

// init all directory files to fd in disk
void
fat_init_fdir(struct fdir* fd)
{
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;
    uint  cs = dir->size;

    char* p = kalloc(PGROUNDUP(cs));
    fs_read_blocks(p,dir->block,dir->dev,cs);
    struct fat_dir* start = p;
    struct fat_dir* end = (uint)start + cs;

    uint val;
    for (;start<end;start++)
    {
        if (*(uint*)start == 0) {
            break;
        }
        // if (f->fat_type == FAT12)
        // {
        // }
        // else 
        if (f->fat_type == FAT16)
        {
            fdir_create(fd,FT_FILE,start->name,start->file_size,
            f->first_data_sector + SWT_BLOCK(start->first_clus_low - 2,f->bpb.bytes_per_sector * f->bpb.sectors_per_cluster));
        }
        // else if (f->fat_type == FAT32) 
        // {
        // }
    }

    kfree(p,cs);
}

// test
void
fat_test(struct fat_info* f,struct fat_dir* dir)
{
    // // find directory file
    // uint root = SWT_BLOCK(f->first_root_sector,f->bpb.bytes_per_sector);
    // uint dsize = PGROUNDUP(f->bpb.root_entry_count*sizeof(struct fat_dir));
    // char* dp = kalloc(dsize);
    // fs_read_blocks(f,dp,root,dsize);

    // uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    // uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    // uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    // char* fp = kalloc(fsize);
    // fs_read_blocks(f,fp,fat1,fsize);

    // fat_clus_create_file(f,fp,dp,dir);
    // // char buf[100] = "1aaaaaaaaaaaaaaa";
    // // fat_clus_write_file(f,dp,dir,buf,100);
    // // uint c = fat_find_name(f,dp,"mydir");
    // // vprintf("%d \n",f->first_data_sector);
    // // vprintf("%d \n",f->first_root_sector);
    // // char* t = kalloc();
    
    // fat_dir_dump(f,dp);

    // fs_write_blocks(f,dp,root,dsize);
    // fs_write_blocks(f,fp,fat1,fsize);
    // fs_write_blocks(f,fp,fat2,fsize);

    // kfree(dp,dsize);
    // kfree(fp,fsize);
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