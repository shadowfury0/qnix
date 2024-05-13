# syscall functions

.globl system_call,sys_fork,sys_wait,sys_yield,sys_exit

error_call:
    movl    $-1,%eax
    addl    $0x0c,%esp
    iret
# int 0x80
system_call:
    cli
    cmpl    $syscall_table_size,%eax
    ja      error_call


    pushl   %ebp
    pushl   %esi
    pushl   %edi
# 3
    pushl   %edx
# 2
    pushl   %ecx
# 1
    pushl   %ebx


    call    syscall_table(,%eax,4)

    popl    %ebx
    popl    %ecx
    popl    %edx

    popl    %edi
    popl    %esi
    popl    %ebp

    sti
    iret

sys_fork:
    cli
#   esp
    pushl   %esp

#   first ebx arg is eip address for syscall
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    fork1
# clean the stack

    popl    %edi
    popl    %esi
    popl    %ebp
    popl    %ebx
    popl    %edx
    popl    %ecx
    addl    $4,%esp
    popl    %esp

    ret

sys_wait:
    pushl   %esp
    pushl   %ebx
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi
    call    wait1
    addl    $0x28,%esp

#   pop syscall before stack
#   addl    $0x18,%esp
    jmp     schedule

sys_yield:
    cli
    pushl   %esp
    pushl   %ebx
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    yield1

    addl    $0x28,%esp
#   pop syscall before stack
#   addl    $0x18,%esp

    jmp     schedule

sys_exit:
    call    exit
    addl    $8,%esp
#   pop syscall before stack
#   addl    $0x18,%esp
    jmp     schedule
