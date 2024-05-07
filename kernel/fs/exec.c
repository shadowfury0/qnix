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
// is work but not perfect
    int* pgdir;
    if((pgdir = setupkvm()) == 0)
        goto bad;

    fat_init(&root,1,"root");
    fat_init_fdir(&root);
    char* p = alloc_page();
    fat_read(&root,path,p,root.cur[2].size);
    // fat_read(&root,"_TEST       ",p,root.cur[2].size);

    uint sz = 0;
    if ((sz = allocuvm(pgdir,sz,root.cur[2].size)) == 0)
        goto bad;

    struct proc* proc = get_cur_proc();
    // change the pgdir
    proc->pgdir = pgdir;
    // running
    switchkvm(pgdir);
    loaduvm(pgdir,p,sz);
    // free_page(p);

    struct elf32_hdr* elf;
    proc->tss.eip = elf->e_entry;
    proc->tss.eax = 0;
//  jmp direct
    swtch(&proc->tss);
bad:
    // free_page(proc->pgdir);
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