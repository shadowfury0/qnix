#include "types.h"
#include "io.h"
#include "mmu.h"
#include "proc.h"

// usr main function
extern void umain(void); 
extern struct segdesc* kgdt;

// proc arrays
struct proc ptable[PT_SIZE];
// first process
static struct proc* curproc;
//current pid
static uint curpid = 0x0;

void
show_procs(void)
{
    int i;
    for (i=0;i<PT_SIZE;i++)
        vprintf("pid : %d , state : %d \n",ptable[i].pid,ptable[i].state);
}

void
proc_init(void)
{
    if (PT_SIZE * sizeof(struct segdesc) >  PGSIZE)
        panic("process table is larger than a page");

    int i;
    for (i = 3;i<PT_SIZE;i++) {
        kgdt[i] = SEG(0,0,0,0);
    }
}

struct proc*
allocproc(void)
{
    struct proc* p;

    for (p = ptable;p < &ptable[PT_SIZE];p++)
        if (p->state == UNUSED)
            goto found;
    
    //not found is all used 
    return 0;
found:

    if ((p->tss.esp = kalloc()) == 0) {
        p->state = UNUSED;
        return 0;
    }
    p->state = EMBRYO;
    p->pid = curpid++;
    p->tss.esp += KSTACKSIZE;
    // curproc is parent process
    p->parent = curproc;

    return p;
}

void 
schedule(void)
{
    struct proc *p;
    for(;;) {
        for (p = ptable;p < &ptable[PT_SIZE];p++) {
            if (p->state != RUNNABLE)
                continue;
            
            p->state = RUNNING;
            curproc = p;
            // asm volatile("leal 1f,%0; jmp *%1; 1:":"=r"(p->reip):"m"(p->tss.eip));
            // swtch(p->reip,p->tss.eip);
        }
    }
}

void
user_init(void)
{
    struct proc* p;
    if((p = allocproc()) == 0)
        panic("user init error");

    p->tss.es   = SEG_KDATA << 3;
    p->tss.cs   = SEG_KCODE << 3;
    p->tss.ss   = SEG_KDATA << 3;
    p->tss.ds   = SEG_KDATA << 3;
    p->tss.fs   = SEG_KDATA << 3;
    p->tss.ss   = SEG_KDATA << 3;
    p->tss.gs   = SEG_KDATA << 3;
    // cur stack point tmp esp0
    p->tss.esp0 = (uint)p->tss.esp; 
    p->tss.eip  = (uint)umain;

    curproc = p;
    p->pid = 0;
    // is the first process need point itself
    p->parent = p;

    p->state = RUNNABLE;

    kgdt[SEG_FIRST] = SEG(SYS_TSS,&p->tss,0x68,0);
    
    ltr(SEG_FIRST);
}

int
kill(uint pid)
{
    struct proc *p;

    for(p = ptable; p < &ptable[PT_SIZE]; p++){
        if(p->pid == pid){
            // p->killed = 1;
            p->state = RUNNABLE;
            // if(p->state == SLEEPING)
                // p->state = RUNNABLE;
            return 0;
        }
    }
    return 1;
}

void
exit(void)
{
    // asm volatile("jmp *%0"::"m"(curproc->reip));
    asm volatile("jmp *%0"::"r"(0x80100956));
}

void
procdump(void)
{
    static char *states[] = {
        [UNUSED]    "unused",
        [EMBRYO]    "embryo",
        [SLEEPING]  "sleep ",
        [RUNNABLE]  "runable",
        [RUNNING]   "running",
        [ZOMBIE]    "zombie"
    };

    struct proc *p;
    char *state;

    for(p = ptable; p < &ptable[PT_SIZE]; p++){
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
            state = states[p->state];
        else
            state = "???";
        vprintf("%d   %d   %s \n",p->pid,p->parent->pid, state);
        // if(p->state == SLEEPING){
        //     getcallerpcs((uint*)p->context->ebp+2, pc);
        //     for(i=0; i<10 && pc[i] != 0; i++)
        //         vprintf(" %p", pc[i]);
        // }
        // vprintf("\n");
    }
}