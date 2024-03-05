#include "i386.h"
uchar inb(ushort port)
{
    uchar data;
    asm volatile("inb %1,%0" : "=a" (data) : "d" (port));
    return data;
}

void outb(ushort port, uchar data)
{
    asm volatile("outb %0,%1" : : "a" (data), "d" (port));
}