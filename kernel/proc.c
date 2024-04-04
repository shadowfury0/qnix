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
static uint curpid;

void
proc_init(void)
{
    curpid = 0;
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
    
    vprintf("the process has reached its maximum value %d \n",PT_SIZE);
    //not found is all used 
    return 0;
found:

    if ((p->tss.esp = kalloc()) == 0) {
        p->state = UNUSED;
        return 0;
    }
    p->state = EMBRYO;
    p->pid = curpid++ & 0xf;
    p->tss.esp += KSTACKSIZE;
    // curproc is parent process
    p->parent = curproc;

    p->tss.es   = SEG_KDATA << 3;
    p->tss.cs   = SEG_KCODE << 3;
    p->tss.ss   = SEG_KDATA << 3;
    p->tss.ds   = SEG_KDATA << 3;
    p->tss.fs   = SEG_KDATA << 3;
    p->tss.ss   = SEG_KDATA << 3;
    p->tss.gs   = SEG_KDATA << 3;

    
    // load tss
    // kgdt[SEG_FIRST] = SEG(SYS_TSS,&p->tss,0x68,0);
    // ltr(SEG_FIRST);

    return p;
}

static inline void
swtch(void)
{
    asm volatile(
        // "leal 1f, %%eax; \n\t"
        // "movl %%eax, %0; \n\t"
        "movl %0,%%esp;\n\t"
        "jmp *%1; \n\t"
        // "1: \n\t"
        // : "=m"(curproc->reip)
        :: "m"(curproc->tss.esp),"m"(curproc->tss.eip)
        : "%eax"
    );
}

void 
schedule(void)
{
    struct proc *p;
    for (p = &ptable[PT_SIZE-1]; p >= ptable; p--) {
        if (p->state == RUNNABLE)
        {
            p->state = RUNNING;
            curproc = p;
            swtch();
            break;
        }
    }

}

void
user_init(void)
{
    struct proc* p;
    if((p = allocproc()) == 0)
        panic("user init error");

    // is the first process need point itself
    p->parent = curproc;
    p->tss.eip  = (uint)umain;
    curproc = p;
    p->parent = p;

    p->state = RUNNABLE;

}

void exit(void);

void
hello(void)
{
    vprintf("hello\n");
    exit();
}

// tmp is error
int
fork(void)
{
    struct proc* cp;

    if((cp = allocproc()) == 0)
        return 1;

    cp->parent = curproc;
    cp->state = RUNNABLE;
    cp->tss.eip = (uint)hello;

    // schedule();
    return cp->pid;
}

int
kill(uint pid)
{
    struct proc *p;
    for(p = ptable; p < &ptable[PT_SIZE]; p++){
        if(p->pid == pid){
            // p->killed = 1;
            p->state = ZOMBIE;
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
    if (curproc->parent == curproc) 
        panic("init exiting");

    curproc->state = ZOMBIE;
    schedule();
    // asm volatile(
    //     "jmp  *%0;\n\t"
    //     ::"m"(curproc->reip));
}

void
sys_getpid(void)
{
    return curproc->pid;
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