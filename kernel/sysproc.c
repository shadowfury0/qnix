#include "types.h"
#include "usr.h"

int
sys_fork(void)
{
    return fork();
}

int
sys_exit(void)
{
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
    yield();
    return 0;
}

int
sys_getpid(void)
{
    return getpid();
}