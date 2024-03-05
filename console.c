#include "i386.h"

// VGA memory address
static ushort *crt = (ushort*)(0xb8000);
void vgaputc() {
    outb(CRTPORT, 15);
    outb(CRTPORT+1, 79);
}