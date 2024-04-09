#include "types.h"
#include "syscall.h"
#include "proc.h"
#include "mmu.h"
// proc.c
extern volatile struct proc* curproc;

extern  int sys_fork(void);
extern  int sys_exit(void);
extern  int sys_wait(void);
extern  int sys_exec(void);
extern  int sys_getpid(void);

static  int (*syscalls[])(void) = {
    [SYS_FORK]  sys_fork,
    [SYS_EXIT]  sys_exit,
    [SYS_WAIT]  sys_wait,
    [SYS_EXEC]  sys_exec,
    [SYS_GPID]  sys_getpid,
};


int
syscall(uint num)
{
    if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
        return syscalls[num]();
    }
    else {
        vprintf("syscall number not found\n");
        return -1;
    }
}