#include "syscall.h"
#include "idt.h"

#define SYSCALL(name) \
.globl name; \
name: \
    movl    $SYS_##name, %eax;\
    int     $T_SYSCALL;\
    ret


SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(gpid)
SYSCALL(exec)
SYSCALL(time)