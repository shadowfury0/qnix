#include "types.h"
#include "io.h"

extern void exit(void);
// tmp
void
umain(void){
    vprintf("enter user space\n");
    // for (;;) {
        procdump();
        stihlt();
        keyputc();
        // asm volatile("int3");
        // kill(0);
        procdump();
    // }
    exit();
}