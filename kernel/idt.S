#include "mmu.h"

.globl do_int0,do_int1,do_int2,do_int3
.globl do_int4,do_int5,do_int6,do_int7
.globl do_int8,do_int9,do_int10,do_int11
.globl do_int12,do_int13,do_int14,do_int16
.globl keyboard_interrupt,do_other

do_int0:
    pushl   $divide_error
no_error:
    xchgl   %eax,(%esp)
    pushl   %ebx
	pushl   %ecx
	pushl   %edx
	pushl   %edi
	pushl   %esi
	pushl   %ebp
    push    %ds
	push    %es
    push    %fs

#   pointing to the address of the function call
    lea 40(%esp),%edx
	pushl %edx
    
    movl    $(SEG_KCODE<<3),%edx
    movw    %dx,%ds
	movw    %dx,%es
	movw    %dx,%fs
    
#   call interrupt function
    call    %eax
    addl    $4,%esp

    pop     %fs
    pop     %es
    pop     %ds
    popl    %ebp
	popl    %esi
	popl    %edi
	popl    %edx
	popl    %ecx
	popl    %ebx
	popl    %eax
    iret

do_int1:
    pushl   $divide_error
    jmp     no_error

# int2 - 非屏蔽中断调用入口点。类型：陷阱；无错误号。
# 这是仅有的被赋予固定中断向量的硬件中断。每当接收到一个NMI信号，CPU内部就会产生中断
# 向量2，并执行标准中断应答周期，因此很节省时间。NMI通常保留为极为重要的硬件事件使用。
# 当CPU收到一个i额NMI信号并且开始执行其中断处理过程时，随后所有的硬件中断都将被忽略。
do_int2:
    pushl   $nmi_error
    jmp     no_error
do_int3:
    pushl   $break_point
    jmp     no_error   
do_int4:
    pushl   $overflow_error
    jmp     no_error  
do_int5:
    pushl   $bound_error
    jmp     no_error      
do_int6:
    pushl   $invalid_code
    jmp     no_error

#This exception occurs in either of two conditions:
#The processor encounters an ESC (escape) instruction, 
#and the EM (emulate) bit ofCR0 (control register zero) is set.
#The processor encounters either the WAIT instruction or an ESC instruction,
#and both the MP (monitor coprocessor) and TS (task switched) bits of CR0 are set.
do_int7:
    pushl   $device_not_available
    jmp     no_error
# int8 - 双出错故障。类型：放弃；有错误码。
# 通常当CPU在调用前一个异常的处理程序而又检测到一个新的异常时，这两个异常会被
# 串行地进行处理，但也会碰到很少的情况，CPU不能进行这样的串行处理操作，此时
# 就会引发该中断。
do_int8:
    pushl   $double_fault
    jmp     no_error

do_int9:
    pushl   $coprocessor_segment_overrun
    jmp     no_error

do_int10:
    pushl   $invalid_tss
    jmp     no_error

do_int11:
    pushl   $segment_not_present
    jmp     no_error

do_int12:
    pushl   $stack_error
    jmp     no_error

do_int13:
    pushl   $general_protection
    jmp     no_error

do_int14:
    pushl   $page_error
    jmp     no_error

do_int16:
    pushl   $coprocessor_error
    jmp     no_error

do_other:
    pushl   $reserve_error
    jmp     no_error

# int 0x21
keyboard_interrupt:
    pushl   $keygetc
    jmp     no_error
