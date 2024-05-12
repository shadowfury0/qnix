#include "types.h"
#include "elf32.h"
#include "io.h"
#include "mmu.h"
#include "proc.h"
#include "ide.h"
#include "fat.h"
#include "fs.h"
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

int
exec(char* path,char** argv)
{
    int* pgdir;
    if((pgdir = setupkvm()) == 0)
        goto bad;

    // find name
    struct proc* proc = fs_read(path);

    uint sz = 0;
    if ((sz = allocuvm(pgdir,sz,proc->file->size)) == 0)
        goto bad;

    // change the pgdir
    proc->upgdir = pgdir;
    // running
    switchkvm(pgdir);
    loaduvm(pgdir,proc->fp,sz);

    struct elf32_hdr* elf;
    proc->tss.eip = elf->e_entry;
    proc->tss.eax = 0;

//  jmp direct
    swtch(&proc->tss);
bad:
    
    return -1;
}

// systemctl execute
int
sys_exec(void* arg1,void* arg2)
{
    return exec(arg1,arg2);
}