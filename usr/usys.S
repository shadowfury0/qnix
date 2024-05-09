#include "syscall.h"
#include "idt.h"

#define SYSCALL(name) \
.globl name; \
name: \
    movl    $SYS_##name, %eax;\
    int     $T_SYSCALL;\
    ret

#define SYSCALL1(name,arg1) \
.globl name; \
name: \
    movl    $SYS_##name, %eax;\
    movl    arg1,%ebx\
    int     $T_SYSCALL;\
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(yield)
SYSCALL(exec)
SYSCALL(time)
SYSCALL(getpid)
SYSCALL(printf)