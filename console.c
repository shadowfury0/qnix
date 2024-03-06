#include "i386.h"
// #include "console.h"
// VGA memory address
static ushort *crt = (ushort*)0xb8000;
static int pos = 0;
void vgaputc(int c) {
    if (pos < 0 ) 
        pos = 0;
    else if (pos > 2000 )
        pos = 0;
    crt[pos++] = c | 0x0700;
}


