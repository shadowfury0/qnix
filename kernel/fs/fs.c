#include "types.h"
#include "mmu.h"
#include "ide.h"
#include "fat.h"
#include "fs.h"

void
fs_read_blocks(char* buf,uint offset,uint dev,uint s)
{
    // ROUND UP
    s = s / SECTSIZE + s % SECTSIZE ? SECTSIZE : 0;
    DEVICE_NFOUND_V(ideread(buf,offset,dev,s / SECTSIZE));
}

void
fs_write_blocks(char* buf,uint offset,uint dev,uint s)
{
    s = s / SECTSIZE + s % SECTSIZE ? SECTSIZE : 0;
    DEVICE_NFOUND_V(idewrite(buf,offset,dev,s/SECTSIZE));
}

void
fnode_init(struct fnode* i)
{
    i->t = 0;
    i->fst = 0;
    i->dev = 0;
    i->size = 0;
    i->block = 0;
    i->p = 0;
    memset(i->name,0,FILE_NAME_SIZE);
}

void
fdir_init(struct fdir* dir,uint fst,uint dev,uint size,uint block,const char* name)
{
    struct  fnode* d = &dir->cur[0];
    d->t = FT_DIR;
    d->fst = fst;
    d->dev = dev;
    d->p = d;
    d->block = block;
    // root directory size
    d->size = size;
    strncpy(d->name,name,strlen(name));
}

// find block
struct fnode*
fdir_find(struct fdir* fd,const char* name)
{
    struct  fnode* s = &fd->cur[2];
    struct  fnode* e = s + sizeof(fd->cur);

    struct fnode* c = 0;
    for (;s < e;s++)
    {
        // end of file in dir
        if (s->t == 0)
            break;
        else if (!strncmp(s->name,name,FILE_NAME_SIZE))
        {
            c = s;
            break;
        }
    }
    return (struct fnode*)c;
}

// return cur id in fdir
uint
fdir_create(struct fdir* fd,uint type,const char* name,uint size,uint block)
{
    // dev type is the same as directory
    struct  fnode*  cur = &fd->cur[0];
    uint    devno  = cur->dev;
    uint    fstype = cur->fst;

    uint    i = 2;
    // start from the second node
    struct  fnode* s = &fd->cur[i];
    struct  fnode* e = s + sizeof(fd->cur);

    for (;s < e;s++,i++)
    {
        // create file in filenode
        if (s->t == FT_NULL)
        {
            s->t = type;
            s->fst = fstype;
            s->dev = devno;
            s->size = size;
            s->block = block;
            strncpy(s->name,name,FILE_NAME_SIZE);
            if (s->t == FT_DIR) {
                // allocate a dir in memory
                s->p = kalloc(s->size);
                fdir_init(s->p,s->fst,s->dev,s->size,s->block,s->name);
                fs_read_blocks(s->p,s->block,s->dev,s->size);
                // current
                memcpy(&s->p->cur[0],s,sizeof(struct fnode));
                // parent
                memcpy(&s->p->cur[1],cur,sizeof(struct fnode));
            }
            break;
        }
        else if (!strncmp(s->name,name,FILE_NAME_SIZE))
            break;
    }

    return  i;
}

void
fdir_delete(struct fdir* fd,const char* name)
{
    // start from the second node
    struct  fnode* s = &fd->cur[2];
    struct  fnode* e = s + sizeof(fd->cur);

    for (;s < e;s++)
    {
        // create file in filenode
        if (!strncmp(s->name,name,FILE_NAME_SIZE))
        {
            s->t = FT_NULL;
            break;
        }
    }
}

// DFS current directory
void
fs_dfs_dir(struct fdir* fd)
{
    fat_init_fdir(fd);
}

void
fnode_dump(struct fnode* f)
{
    if (f->t == FT_NULL) return;
    vprintf("file system type: %d \n",f->fst);
    vprintf("file type: %d \n",f->t);
    vprintf("device : %d \n",f->dev);
    vprintf("size : %d \n",f->size);
    vprintf("block : %d \n",f->block);
    vprintf("name : %s \n",f->name);
}

// ls current directory
void
fs_ls(struct fdir* fd)
{
    if (fd == 0)
        return;
    
    struct  fnode* s = &fd->cur[2];
    struct  fnode* e = s + sizeof(fd->cur);
    // .
    vprintf("%11s    %d\n",".",fd->cur[0].size);
    // .. 
    vprintf("%11s    %d\n","..",fd->cur[1].size);

    for (;s < e;s++)
    {
        if (s->t == 0)
            break;
        vprintf("%11s    %d\n",s->name,s->size);
    }
}

void
fs_tree(struct fdir* fd,int level)
{
    if (fd == 0)
        return;
    
    struct  fnode* s = &fd->cur[2];
    struct  fnode* e = s + sizeof(fd->cur);

    // .
    // vprintf("%11s    %d\n",".",fd->cur[0].size);
    // .. 
    // vprintf("%11s    %d\n","..",fd->cur[1].size);

    for (;s < e;s++)
    {
        if (s->t == 0)
            break;
        
        for (int i=0;i<level;i++)
            vprintf("\t");
        vprintf("%11s    %d\n",s->name,s->size);
        if(s->t == FT_DIR)
            fs_tree(s->p,++level);
    }
}