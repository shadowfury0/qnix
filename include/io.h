#include "type.h"

static inline uchar inb(ushort port)
{
    uchar data;
    asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    return data;
}

static inline void
insl(int port, void *addr, int cnt)
{
    asm volatile("cld; rep insl" :
                "=D" (addr), "=c" (cnt) :
                "d" (port), "0" (addr), "1" (cnt) :
                "memory", "cc");
}

static inline void
outsl(int port, void *addr, int cnt)
{
    asm volatile("cld; rep outsl" :
                "=S" (addr), "=c" (cnt) :
                "d" (port), "0" (addr), "1" (cnt) :
                "memory", "cc");
}

static inline void outb(ushort port, uchar data)
{
    asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void outw(ushort port, ushort data)
{
    asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
    asm volatile("cld; rep stosb" :
                "=D" (addr), "=c" (cnt) :
                "0" (addr), "1" (cnt), "a" (data) :
                "memory", "cc");
}

static inline void
stosl(void *addr, int data, int cnt)
{
    asm volatile("cld; rep stosl" :
                "=D" (addr), "=c" (cnt) :
                "0" (addr), "1" (cnt), "a" (data) :
                "memory", "cc");
}

static inline void cli(void)
{
    asm volatile("cli");
}

static inline void sti(void)
{
    asm volatile("sti");
}

static inline void hlt(void)
{
    asm volatile("hlt");
}

static inline void stihlt(void)
{
    asm volatile("sti;hlt");
}

static inline void
lcr3(uint val)
{
    asm volatile("movl %0,%%cr3" : : "r" (val));
}

static inline void
lidt(struct gatedesc *p, int size)
{
    volatile ushort idt[3];

    idt[0] = size-1;
    idt[1] = (uint)p;
    idt[2] = (uint)p >> 16;

    asm volatile("lidt (%0)" : : "r" (idt));
}