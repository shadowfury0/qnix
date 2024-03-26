#include "io.h"
#include "tty.h"
#include "mmu.h"

extern char kend[];

const char* welcome = "\
  xxxxxxxxx   xx      xx   xxxx      xx   xxx  xx     xx\n\
  xx     xx   xx      xx   xx xx     xx   xxx   xx   xx \n\
  xx     xx   xx      xx   xx  xx    xx   xxx    xx xx  \n\
  xx     xx   xx      xx   xx   xx   xx   xxx     xxx   \n\
  xx   xxxx   xx      xx   xx    xx  xx   xxx    xx xx  \n\
  xx     xxx   xx    xx    xx     xx xx   xxx   xx   xx \n\
  xxxxxxxxx x   xxxxxx     xx      xxxx   xxx  xx     xx\n\
";

void
init_welcome()
{
    vprintf(welcome);
    vgaputc('\n');
}

void 
init() {
    kminit(P2V(kend),P2V(4*1024*1024));
    // kvmalloc();

    init_idt();
    init_pic();

    init_keyboard();
    init_welcome();
    cpuinfo();
    vprintf("loading...\n");
    
    sti();
    for (;;) {
        stihlt();
        keyputc();
        // asm volatile("int3");
    }
}

__attribute__((__aligned__(PGSIZE)))
uint pgdir[1024] = {
// Map VA's [0, 4MB) to PA's [0, 4MB)
    [0] = (0) | PTE_P | PTE_W | PTE_PS,
// Map VA's [KBASE, KBASE+4MB) to PA's [0, 4MB)
    [KBASE>>PDSHIFT] = (0) | PTE_P | PTE_W | PTE_PS,
};