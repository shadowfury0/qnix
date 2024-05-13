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

// tmp allocate file buffer pointer

int
exec(char* path,char** argv)
{
    static char* buf;
    int* pgdir,oldpgdir;
    if((pgdir = setupkvm()) == 0)
        goto bad;

    struct proc* proc = myproc();

    // find name
    struct fnode* file = fs_read(path,&buf);
    uint sz = 0;
    if ((sz = allocuvm(pgdir,sz,file->size)) == 0)
        goto bad;
    
    // change the pgdir
    oldpgdir = proc->pgdir;
    proc->pgdir = pgdir;

    // running
    switchkvm(pgdir);
    loaduvm(pgdir,buf,sz);

    struct elf32_hdr* elf;
    proc->tss.eip = elf->e_entry;
    proc->tss.eax = 0;

    uint argc = count(argv);
    // user args maximum
    // char arg[MAXARG];
    // asm volatile("pushl %0"::"r"(i));
    
    // push argc
    proc->tss.esp -= 4;
    memmove((uint)proc->tss.esp,&argc,4);
    proc->tss.esp -= 4;
    
    // push argv into user program
    // the last value is 0
    // char** s;
    // for (s=argv;*s != 0;s++)
    // {
    //     asm volatile("pushl %0"::"r"(*s));
    // }
    free_page(oldpgdir);
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