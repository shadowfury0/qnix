#include "def.h"

# int 0
.globl divide_error
divide_error:
    iret

# int 0x21
.globl keyboard_interrupt
keyboard_interrupt:
    pusha
    push    %ds
	push    %es

    call    keygetc

    pop     %es
    pop     %ds
    popa
    iret
