# syscall functions

.globl system_call,sys_exec

error_call:
    movl    $-1,%eax
    addl    $0x0c,%esp
    iret
# int 0x80
system_call:
    cli
    cmpl    $syscall_table_size,%eax
    ja      error_call


# 2
    pushl   %edx
# 1
    pushl   %ecx
# 3
#   pushl   %ebx
    call    syscall_table(,%eax,4)

    addl    $0x8,%esp

    sti
    iret