#include "i386.h"
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

static inline void cli(void)
{
    asm volatile("cli");
}

static inline void sti(void)
{
    asm volatile("sti");
}
