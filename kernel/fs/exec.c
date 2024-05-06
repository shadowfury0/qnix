#include "types.h"
#include "elf32.h"
#include "io.h"
#include "mmu.h"
#include "proc.h"
#include "dev/ide.h"
#include "fs/fat.h"
#include "fs/fs.h"

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
exec1(char* path,char** argv)
{
    int* pgdir;
    if((pgdir = setupkvm()) == 0)
        goto bad;

    fat_init(&root,1,"root");
    fat_init_fdir(&root);
    char* p = alloc_page();
    fat_read(&root,"_TEST       ",p,root.cur[2].size);

    uint sz = 0;
    if ((sz = allocuvm(pgdir,sz,root.cur[2].size)) == 0)
        goto bad;

    struct proc* proc = get_cur_proc();
    free_page(proc->pgdir);
    // change the pgdir
    proc->pgdir = pgdir;
    switchkvm(pgdir);
    loaduvm(pgdir,p,sz);

    struct elf32_hdr* elf;
    proc->tss.eip = elf->e_entry;
//  jmp direct
    swtch(&proc->tss);
bad:
    free_page(p);
    fat_clean(1);
    
    return -1;
}
