#include "types.h"
#include "usr.h"
#include "proc.h"

extern struct proc* curproc;

int
sys_fork(void)
{
    return fork();
}

int
sys_exit(void)
{
    // ip ebx ecx edx
    // asm volatile("addl $0x0c,%esp; call exit");
    exit();
    return 0;
}

int
sys_wait(void)
{
    return wait();
}

int
sys_yield(void)
{
<<<<<<< HEAD
    // ip ebx ecx edx
    // asm volatile("addl $0x4,%esp");
=======
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
    yield();
    return 0;
}

int
sys_getpid(void)
{
    return getpid();
}