#include "syscall.h"
#include "idt.h"
.globl umain
umain:
    movl    $SYS_GPID, %eax
    int     $T_SYSCALL

exit:
    jmp     exit

    movl    $SYS_EXIT,%eax
    int     $T_SYSCALL
    jmp     exit