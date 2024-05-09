#include "types.h"
#include "io.h"
#include "elf32.h"
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
// c read size byte
void
readseg(uchar* s, uint c, uint offset)
{
    uchar* e;
    e = s + c;
    // Round down to sector boundary.
    s -= offset % SECTSIZE;

    // Translate from bytes to sectors; kernel starts at sector 1.
    offset = (offset / SECTSIZE) + 1;

    // If this is too slow, we could read lots of sectors at a time.
    // We'd write more to memory than asked, but it doesn't matter --
    // we load in increasing order.
    for(; s < e; s += SECTSIZE, offset++)
        readsect(s, offset);
}

void 
bootmain(void) 
{
    struct elf32_hdr* elf;
    void(*entry)();
    elf = (struct elf32_hdr*)0x100000;

    //一次性读满
    readseg((uchar*)elf, 30720, 0);

    if ( elf->e_magic != ELF32_MAGIC ) 
        return;

    entry = (void(*)(void))(elf->e_entry);
    entry();
}