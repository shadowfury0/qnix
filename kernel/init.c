#include "io.h"

const char* welcome = "\
  xxxxxxxxx   xx      xx   xxxx      xx   xxx  xx     xx\n\
  xx     xx   xx      xx   xx xx     xx   xxx   xx   xx \n\
  xx     xx   xx      xx   xx  xx    xx   xxx    xx xx  \n\
  xx     xx   xx      xx   xx   xx   xx   xxx     xxx   \n\
  xx   xxxx   xx      xx   xx    xx  xx   xxx    xx xx  \n\
  xx     xxx   xx    xx    xx     xx xx   xxx   xx   xx \n\
  xxxxxxxxx x   xxxxxx     xx      xxxx   xxx  xx     xx\n\
";

//暂时这么用
extern uchar value;

void
init_welcome()
{
    vprintf(welcome);
    vgaputc('\n');
    vprintf("loading...\n");
}

void 
init() {
    value = 0;
    init_idt();
    init_pic();
    sti();

    init_keyboard();

    init_welcome();
    for (;;) {
        vprintf("--> ");
        if (value != 0) {
            cli();
            printint(value,16);
            value = 0;
        }
        stihlt();
        vgaputc('\n');
    }
}
