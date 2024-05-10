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

<<<<<<< HEAD

# 2
    pushl   %edx
# 1
    pushl   %ecx
# 3
#   pushl   %ebx
=======
# 3
    pushl   %ebx
# 2
    pushl   %edx
# 1
    pushl   %ecx    
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
    call    syscall_table(,%eax,4)

<<<<<<< HEAD
    addl    $0x8,%esp

    sti
=======
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
    iret