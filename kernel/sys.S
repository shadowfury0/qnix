# syscall functions

.globl system_call,sys_fork,sys_wait,sys_yield,sys_exit

error_call:
    movl    $-1,%eax
    addl    $0x0c,%esp
    sti
    iret
# int 0x80
system_call:
    cli
    cmpl    $syscall_table_size,%eax
    ja      error_call

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

    sti
    iret

sys_fork:
#   esp
    pushl   %esp

#  eip address for syscall
    pushl   0x40(%esp)
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
    addl    $0x3c,%esp
#   esp
    pushl   %esp

#  eip address for syscall
    pushl   0x4(%esp)
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    wait1
    addl    $0x28,%esp

    jmp     schedule

sys_yield:
    addl    $0x3c,%esp
#   esp
    pushl   %esp

#  eip address for syscall
    pushl   0x4(%esp)
    pushl   %eax
    pushl   %ecx
    pushl   %edx
    pushl   %ebx
    pushl   %ebp
    pushl   %esi
    pushl   %edi

    call    yield1
    addl    $0x28,%esp

    jmp     schedule

sys_exit:
    call    exit
    addl    $8,%esp
#   addl    $0x18,%esp
    jmp     schedule
