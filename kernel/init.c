#include "io.h"
#include "tty.h"

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
    vprintf("loading...\n");
}

void 
init() {
    init_idt();
    init_pic();

    init_keyboard();
    init_welcome();

    for (;;) {
        stihlt();
        keyputc();
        // asm volatile("int3");
    }
}
