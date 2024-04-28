#include "types.h"
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
welcome_init(void)
{
    vprintf(welcome);
    vgaputc('\n');
}

void 
main(void) 
{
    kminit1(kend,P2V(3*1024*1024));    

    kvminit();
    seginit();
    proc_init();

    welcome_init();
    cpuinfo();
    vprintf("loading...\n");

    idt_init();
    pic_init();
    keyboard_init();
    rtc_init();
    ide_init();
    
    sti();
    user_init();
    schedule();
}

__attribute__((__aligned__(PGSIZE)))
int pgdir[PGTSIZE] = {
// Map VA's [0, 4MB) to PA's [0, 4MB)
    [0] = (0) | PTE_P | PTE_W | PTE_PS,
// Map VA's [KBASE, KBASE+4MB) to PA's [0, 4MB)
    [KINDEX] = (0) | PTE_P | PTE_W | PTE_PS,
};