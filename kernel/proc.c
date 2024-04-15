#include "types.h"
#include "io.h"
#include "mmu.h"
#include "proc.h"

// usr main function
extern void umain(void);

extern struct segdesc* kgdt;

// process arrays
static struct proc ptable[PT_SIZE];
// first process
volatile struct proc* curproc;
// current pid
static uint curpid;

void 
schedule(void)
{
    volatile struct proc *p;

    for(;;) {
        for (p = ptable; p < &ptable[PT_SIZE]; p++) {
            if (p->state == EMBRYO) {
                p->state = RUNNABLE;
                continue;
            }
            else if (p->state != RUNNABLE)
                continue;
            // switch cur process
            curproc = p;
            p->state = RUNNING;
            swtch(&p->tss);
        }

        // clean the process
        for (p = ptable; p < &ptable[PT_SIZE]; p++) {
            if (p->state != ZOMBIE) 
                continue;
            p->parent->state = RUNNABLE;
            // clear stack
            kfree(PGROUNDUP(p->tss.esp-PGSIZE));
            p->state = UNUSED;
            p->parent = 0;
            p->pid = 0;
        }
    }
}

void
proc_init(void)
{
    curpid = 0;
    curproc = 0;

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
    // kgdt[SEG_FIRST+tssid] = SEG(SYS_TSS,&p->tss,0x68,0);
    // ltr(SEG_FIRST);

    return p;
}

// usr enter space
void umain(void);
void test(void);

void
user_init(void)
{
    struct proc* p;
    if((p = allocproc()) == 0)
        panic("user init error");
    
    // don't change this is point to 0x0 address for user enter size is fixed  
    // memmove(0,&umain, 0x1a);
    // is the first process need point itself
    // p->tss.eip = 0;
    p->tss.eip = &test;
    curproc = p;
    p->parent = p;

    p->state = RUNNABLE;
}

int
fork1(uint edi,uint esi,uint ebp,uint ebx,uint edx,uint ecx,uint eip,uint esp)
{
    struct proc* cp;

    if((cp = allocproc()) == 0)
        return -1;

    cp->state = RUNNABLE;
    cp->tss.eip = eip;
    char* src = (char*)PGROUNDUP(curproc->tss.esp - PGSIZE);
    char* dst = (char*)PGROUNDUP(cp->tss.esp - PGSIZE);
    memmove(dst,src,PGSIZE);

    cp->tss.eax = 0;
    cp->tss.esp -= (curproc->tss.esp - esp - 4);
    cp->tss.ecx = ecx;
    cp->tss.edx = edx;
    cp->tss.ebx = ebx;
    cp->tss.ebp = ebp;
    cp->tss.esi = esi;
    cp->tss.edi = edi;

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
wakeup(struct proc* w)
{
    if (w->state == SLEEPING)
        w->state = RUNNABLE;
}

void
exit(void)
{
    struct proc* p = curproc;
    if (p->parent == curproc)
        panic("init exiting");

    // parent wake up
    wakeup(p->parent);

    p->tss.eip = &schedule;
    p->state = ZOMBIE;
    swtch(&p->tss);
}

int
wait1(uint edi,uint esi,uint ebp,uint ebx,uint edx,uint ecx,uint eax,uint eip,uint esp)
{
    if (curproc == 0)
        panic("sleep");
    
    volatile struct proc* p;
    for (p = ptable; p < &ptable[PT_SIZE]; p++) {
        if (p->parent != curproc || curproc == p)
            continue;
        
        // sleep cur process
        curproc->state = SLEEPING;
        curproc->tss.eip = eip;
        // call ip need add 4
        curproc->tss.esp = esp+4;
        curproc->tss.eax = eax;
        curproc->tss.ecx = ecx;
        curproc->tss.edx = edx;
        curproc->tss.ebx = ebx;

        curproc->tss.ebp = ebp;
        curproc->tss.edi = edi;
        curproc->tss.esi = esi;
        return p->pid;
    }
    return 0;
}

void
yield1(uint edi,uint esi,uint ebp,uint ebx,uint edx,uint ecx,uint eax,uint eip,uint esp)
{
    curproc->state = EMBRYO;
    curproc->tss.eip = eip;
    // call ip need add 4
    curproc->tss.esp = esp+4;
    curproc->tss.ebp = ebp;
    curproc->tss.edi = edi;
    curproc->tss.esi = esi;

    curproc->tss.eax = eax;
    curproc->tss.ecx = ecx;
    curproc->tss.edx = edx;
    curproc->tss.ebx = ebx;
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

int
getpid(void)
{
    return curproc->pid;
}

