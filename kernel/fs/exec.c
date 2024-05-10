#include "types.h"
#include "elf32.h"
#include "io.h"
#include "mmu.h"
#include "proc.h"
#include "dev/ide.h"
#include "fs/fat.h"
#include "fs/fs.h"
#include "usr.h"

static int
count(char** argv)
{
    char** s;
    uint i;
    // the last value is 0
    for (s=argv;*s != 0;s++,i++);
    return i;
}

struct fdir  root;

int
exec(char* path,char** argv)
{
    int* pgdir;
    if((pgdir = setupkvm()) == 0)
        goto bad;

    fat_init(&root,1,"root");
    fat_init_fdir(&root);
    char* p = alloc_page();

    // find name
    struct fnode* node = fdir_find(&root,"_INIT       ");
    fat_read(&root,"_INIT       ",p,node->size);

    uint sz = 0;
    if ((sz = allocuvm(pgdir,sz,node->size)) == 0)
        goto bad;

    struct proc* proc = get_cur_proc();
    // change the pgdir
    proc->upgdir = pgdir;
    // running
    switchkvm(pgdir);
    loaduvm(pgdir,p,sz);

    struct elf32_hdr* elf;
    proc->tss.eip = elf->e_entry;
    proc->tss.eax = 0;

//  jmp direct
    swtch(&proc->tss);
bad:
    // free_page(p);
    fat_clean(1);
    
    return -1;
}

// systemctl execute
int
sys_exec(void* arg1,void* arg2)
{
    return exec(arg1,arg2);
}