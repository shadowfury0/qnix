#include "mmu.h"

.code32
.globl _start
_start:
# Turn on page size extension for 4Mbyte pages
    movl    %cr4, %eax
    orl     $(CR4_PSE), %eax
    movl    %eax, %cr4
# Set page directory
    movl    $(pgdir), %eax
    movl    %eax, %cr3
# Turn on paging.
    movl    %cr0, %eax
    orl     $(CR0_PG|CR0_WP), %eax
    movl    %eax, %cr0
    movl    $(kstack+KSTACKSIZE),%esp

    call    init

.comm kstack, KSTACKSIZE