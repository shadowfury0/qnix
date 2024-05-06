#include "syscall.h"
#include "idt.h"
.globl umain
umain:
    movl    $init,%edx
    movl    $argv,%ecx
    movl    $SYS_exec, %eax
    int     $T_SYSCALL

exit:
    movl    $SYS_exit,%eax
    int     $T_SYSCALL
    jmp     exit

# char init[] = "/init\0";
init:
    .string "/init\0"
# char *argv[] = { init, 0 };   
argv:
    .long   init
    .long   0