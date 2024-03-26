// Physical memory allocator, intended to allocate
// Kernel allocate memory allocates 4096-byte pages
#include "io.h"
#include "mmu.h"

extern char kend[];

struct km_node {
    struct km_node* next;
};
// free memory list
struct {
    struct km_node* h;
} kmem;

void
kfree(char* v)
{
    struct km_node* r;
    // fill with junk
    memset(v,1,PGSIZE);
    // not pagesize times
    if((uint)v % PGSIZE || v < kend || V2P(v) >= PHYSTOP)
        panic("kfree");
    r = (struct km_node*)v;
    r->next = kmem.h;
    kmem.h = r;
}

void
freerange(void* start,void* end)
{
    char* p;
    p = (char*)PGROUNDUP((uint)start);
    for(;p + PGSIZE <= (char*)end; p += PGSIZE)
        kfree(p);
}

char*
kalloc(void)
{
    struct km_node* m;
    m = kmem.h;
    if (m)
        kmem.h = m->next;
    return (char*)m;
}

void
kminit(void* vstart,void* vend)
{
    kmem.h = 0;
    freerange(vstart,vend);
}