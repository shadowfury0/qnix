#include "types.h"
#include "mmu.h"
#include "ide.h"
#include "fat.h"
#include "fs.h"

struct  fs_info fs_info;

extern struct ide_device ide_devices[IDE_DEV_SIZE];


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
        f->fat_type = EXFAT;
    else if(f->total_clusters < FAT12_CLUST ) 
        f->fat_type = FAT12;
    else if(f->total_clusters < FAT16_CLUST) 
        f->fat_type = FAT16;
    else
        f->fat_type = FAT32;

    memset(dir,0,sizeof(struct fdir));
    fdir_init(dir,FS_FAT,n,f->bpb.root_entry_count*sizeof(struct fat_dir),
    SWT_BLOCK(f->first_root_sector,f->bpb.bytes_per_sector),name);

    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    f->fp = kalloc(fsize);
    fs_read_blocks(f->fp,fat1,n,fsize);
}

void
fat_clean(uint n)
{
    struct  fat_info* f = &fs_info.u[n].fat;
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);
    kfree(f->fp,fsize);
}

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

    uint offset = j-i;
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

void
fat16_clus_delete(struct fat_info* f,uint fi)
{
    volatile ushort* s = (ushort*)f->fp;
    ushort* e = (uint)s + f->fat_size * f->bpb.bytes_per_sector;

    uint i = FAT16_NEXT(f->fp,fi);
    ((ushort*)f->fp)[fi] = 0;
    while (i)
    {
        // clear
        ((ushort*)f->fp)[i] = 0;
        i = FAT16_NEXT(f->fp,i);
    }
}

// list current dir all file or dir information
void
fat_dir_dump(struct fat_info* f,uint* dir)
{
    struct fat_dir* s = (struct fat_dir*)dir;
    struct fat_dir* e = (uint)s + f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;

    for (;s<e;s++)
    {
        if (*(uint*)s == 0) break;
        vprintf("%x   %d  %s\n",s->attr,s->file_size,s->name);
    }
}

// create in current dir
void
fat_create(struct fdir* fd,const char* name,uint size,uint type)
{
    // current dir
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;

    if (f->fat_type == FAT16 || f->fat_type == FAT12)
        if (strlen(name) > 11)
        {
            vprintf("name is longer than 11 in fat file system\n");
            return;
        }

    // find directory file
    uint dsize = PGROUNDUP(f->bpb.root_entry_count*sizeof(struct fat_dir));
    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = BGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);

    uint  cs = dir->size;

    char* p = kalloc(PGROUNDUP(cs));
    struct fat_dir* start = p;
    fs_read_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));
    struct fat_dir* end = (uint)start + cs;

    uint val;
    struct  fat_dir* tmp = 0;
    uint flag = true;
    for (;start<end;start++)
    {
        val = *(uint*)start;
        if (val && !strncmp(start->name,name,11))
        {
            vprintf("file or directory is exist\n");
            kfree(p,PGROUNDUP(cs));
            return;
        }
        if (flag && (start->name[0] == DIR_ENTRY_FREE || start->name[0] == 0)) {
            tmp = start;
            flag = false;
        }
    }

    // directory is full
    if (!tmp) {
        vprintf("directory is full\n");
        kfree(p,PGROUNDUP(cs));
        return;
    }

    // val is free 0xe5 is free
    // if (f->fat_type == FAT12)
    // {
    // }
    // else 
    if (f->fat_type == FAT16)
    {
        if(!(tmp->first_clus_low = fat16_clus_create(f,size)))
        {
            vprintf("cluster is full\n");
            kfree(p,PGROUNDUP(cs));
            return;
        }
        else
        {
            // is dir
            if (type == FT_DIR)
                tmp->attr = ATTR_DIRECTORY;
            tmp->crt_time = (rtc_get_hour() << 11) | (rtc_get_minute() << 5) | rtc_get_second();
            tmp->crt_date = ((rtc_get_year() - FAT16_DOS_YEAR )<< 9)  | (rtc_get_month() << 5)  | rtc_get_day();
            tmp->last_acc_date = tmp->crt_date;
            tmp->write_time = tmp->crt_time;
            tmp->write_date = tmp->crt_date;
            tmp->first_clus_high = 0;
            tmp->file_size = size;
            strncpy(tmp->name,name,11);
        }
    }
    else if (f->fat_type == FAT32) 
    {
    }

    fdir_create(fd,type,name,size,
    SWT_BLOCK(f->first_data_sector,f->bpb.bytes_per_sector) 
    + SWT_BLOCK(tmp->first_clus_low - 2,f->bpb.bytes_per_sector * f->bpb.sectors_per_cluster));

    if (type == FT_DIR) {
        char* cur = kalloc(PGROUNDUP(size));
        uint  c = FAT2DATB(f,tmp->first_clus_low);
        fs_read_blocks(cur,c,dir->dev,PGROUNDUP(size));
        // .
        struct fat_dir*  dot = (struct fat_dir*)cur;
        memcpy(dot,tmp,sizeof(struct fat_dir));
        dot->attr = ATTR_DIRECTORY;
        // why this beacuse the system define 
        strncpy(dot->name,FAT_CUR_DIR,11);
        dot++;
        // ..
        memcpy(dot,tmp,sizeof(struct fat_dir));
        strncpy(dot->name,FAT_PRE_DIR,11);
        dot->file_size = fd->cur[0].size;
        dot->attr = ATTR_DIRECTORY;
        fs_write_blocks(cur,c,dir->dev,PGROUNDUP(size));
        
        kfree(cur,PGROUNDUP(size));
    }

    fs_write_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));

    kfree(p,PGROUNDUP(cs));

    // if create error recreate
    if (!fdir_find(fd,name)) {
        fat_create(fd,name,size,type);
    }
    else {
        fs_write_blocks(f->fp,fat1,dir->dev,fsize);
        fs_write_blocks(f->fp,fat2,dir->dev,fsize);
    }
}

void
fat_delete(struct fdir* fd,const char* name)
{
    // current dir
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;
    // find directory file
    uint fat1 = SWT_BLOCK(f->first_fat_sector,f->bpb.bytes_per_sector);
    uint fat2 = SWT_BLOCK(f->second_fat_sector,f->bpb.bytes_per_sector);
    uint fsize = PGROUNDUP(f->fat_size * f->bpb.bytes_per_sector);

    uint  cs = dir->size;

    char* p = kalloc(PGROUNDUP(cs));
    struct fat_dir* start = p;
    fs_read_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));
    struct fat_dir* end = (uint)start + cs;

    uint val;
    for (;start<end;start++)
    {
        val = *(uint*)start;
        if (val && !strncmp(start->name,name,11))
        {
            if (f->fat_type == FAT12)
            {
            }
            else if (f->fat_type == FAT16)
            {
                val = start->first_clus_low;
                // set the free state
                start->name[0] = DIR_ENTRY_FREE;
            }
            else if (f->fat_type == FAT32) 
            {
            }
            break;
        }
        // not found
        val = 0;
    }

    if(!val) 
    {  
        vprintf("file not found \n");
        kfree(p,PGROUNDUP(cs));
        return;
    }

    fat16_clus_delete(f,val);

    fdir_delete(fd,name);

    fs_write_blocks(f->fp,fat1,dir->dev,fsize);
    fs_write_blocks(f->fp,fat2,dir->dev,fsize);
    fs_write_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));

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
    
    // if the file size is less than the len
    if (len > cs)
    {
        vprintf("file is smaller than write buffer\n");
        return;
    }

    char* p = kalloc(cs);

    uint  i = node->block;
    char* bufstart = buf;
    while (i != EOC_16) {
        memset(p,0,cs);
        fs_read_blocks(p,i,dir->dev,cs);
        // copy data
        if (len > bs)
            memcpy(p,bufstart,bs);
        else
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

// buf is put read pointer
void
fat_read(struct fdir* fd,const char* name,void* buf,uint len)
{
    struct fnode* node = fdir_find(fd,name);
    if(!node)
    {
        vprintf("file or directory not found in read function  \n");
        return;
    }
    
    struct fnode* dir = &fd->cur[0];
    struct fat_info* f = &fs_info.u[dir->dev].fat;

    uint  cs = node->size;
    uint  bs = f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector;
    
    // if the file size is less than the len
    if (len > cs)
    {
        vprintf("file is smaller than read buffer\n");
        return;
    }

    cs = PGROUNDUP(cs / (f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector)
    + (cs % (f->bpb.sectors_per_cluster * f->bpb.bytes_per_sector) ? bs : 0));

    uint  i = node->block;
    char* bufstart = buf;
    while (i != EOC_16) {
        // copy data
        if (len > bs)
            fs_read_blocks(bufstart,i,dir->dev,bs);
        else
            fs_read_blocks(bufstart,i,dir->dev,len);
        len -= bs;
        bufstart += bs;
        // find next cluster
        i = FAT16_NEXT(f->fp,DATB2FAT(f,i));
        if (i != EOC_16) i = FAT2DATB(f,i);
    }
}

// init all directory files to fd in disk
void
fat_init_fdir(struct fdir* fd)
{
    struct fnode* dir = &fd->cur[0];
    // is not dir
    if (dir->t != FT_DIR)  {
        vprintf(" is not dir\n");
        return;
    }

    struct fat_info* f = &fs_info.u[dir->dev].fat;
    uint  cs = dir->size;

    char* p = kalloc(PGROUNDUP(cs));
    fs_read_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));
    struct fat_dir* start = p;
    struct fat_dir* end = (uint)start + cs;


    uint val;
    for (;start<end;start++)
    {
        if (*(uint*)start == 0) {
            break;
        }
        // skip . .. dir
        else if (!strncmp(start->name,FAT_CUR_DIR,11) || !strncmp(start->name,FAT_PRE_DIR,11))
            continue;
        // if (f->fat_type == FAT12)
        // {
        // }
        // else 
        if (f->fat_type == FAT16)
        {
            if (start->attr & ATTR_DIRECTORY) 
            {
                uint di = fdir_create(fd,FT_DIR,start->name,start->file_size,
                f->first_data_sector + SWT_BLOCK(start->first_clus_low - 2,f->bpb.bytes_per_sector * f->bpb.sectors_per_cluster));
                
                // dfs the directory
                fat_init_fdir(fd->cur[di].p);
            }
            else
                fdir_create(fd,FT_FILE,start->name,start->file_size,
                f->first_data_sector + SWT_BLOCK(start->first_clus_low - 2,f->bpb.bytes_per_sector * f->bpb.sectors_per_cluster));
        }
        // else if (f->fat_type == FAT32) 
        // {
        // }
    }

    fs_write_blocks(p,dir->block,dir->dev,PGROUNDUP(cs));

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