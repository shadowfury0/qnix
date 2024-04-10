# syscall functions

.globl system_call,sys_exec

error_call:
    movl    $-1,%eax
    iret
# int 0x80
system_call:
    cmpl    $syscall_table_size,%eax
    ja      error_call

    push    %ds
	push    %es
	push    %fs
#   call    parameter
# 3
	pushl   %ebx
# 2
	pushl   %ecx
# 1
    pushl   %edx    
    call    syscall_table(,%eax,4)
    addl    $0x0c,%esp

    pop     %fs
    pop     %es
    pop     %ds
    iret
    
# sys exec
sys_exec:
    call    exec
    ret