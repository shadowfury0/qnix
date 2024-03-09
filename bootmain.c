#include "i386.h"
#include "io.h"
#define SECTSIZE  512
void
waitdisk(void)
{
    // Wait for disk ready.
    // while((inb(0x1F7) & 0xC0) != 0x40)
    while ( (inb(0x1F7) & 0x88 ) != 8 ) 
        ;
}

// Read a single sector at offset into dst.
void
readsect(void *dst, uint offset)
{
    // Issue command.
    outb(0x1F2, 1);   // count = 1
    outb(0x1F3, offset);
    outb(0x1F4, offset >> 8);
    outb(0x1F5, offset >> 16);
    outb(0x1F6, (offset >> 24) | 0xE0);
    outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

    // Read data.
    waitdisk();
    insl(0x1F0, dst, SECTSIZE/4);
}

void
writesect(void* dst,uint offset) {
    outb(0x1F2, 1);   // count = 1
    outb(0x1F3, offset);
    outb(0x1F4, offset >> 8);
    outb(0x1F5, offset >> 16);
    outb(0x1F6, (offset >> 24) | 0xE0);
    outb(0x1F7, 0x30);  // cmd 0x30 - write sectors
    // Write data.
    waitdisk();
    outsl(0x1F0, dst, SECTSIZE/4);
}

void 
bootmain() {
    void* entry = (void*)0x7e00;
    readsect(entry,1);

}