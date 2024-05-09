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

# 3
	pushl   %ebx
# 2
	pushl   %edx
# 1
    pushl   %ecx    
    call    syscall_table(,%eax,4)
    addl    $0x0c,%esp

    pop     %fs
    pop     %es
    pop     %ds
    iret