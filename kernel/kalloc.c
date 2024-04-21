// Physical memory allocator, intended to allocate
// Kernel allocate memory allocates 4096-byte pages
#include "types.h"
#include "io.h"
#include "mmu.h"

extern char kend[];

struct km_node {
    uint    size;
    struct  km_node* next;
};
// free memory list
struct {
    struct km_node* h;
} kmem;

// free a page
void
free_page(char* v)
{
    struct km_node* r;

    // not pagesize times
    if((uint)v % PGSIZE || v < kend || V2P(v) >= PHYSTOP)
        panic("kfree");
    // fill with junk
    memset(v,1,PGSIZE);
    r = (struct km_node*)v;
    r->next = kmem.h;
    r->size = PGSIZE;
    kmem.h = r;
}

// kernel free size
void
kfree(char* v,uint size)
{
    struct km_node* s;

    if((uint)v % PGSIZE || v < kend || V2P(v) >= PHYSTOP)
        panic("kfree");
    // fill with junk
    memset(v,1,PGROUNDUP(size));
    s = (struct km_node*)v;
    s->next = kmem.h;
    s->size = PGROUNDUP(size);
    kmem.h = s;
}

void
freerange(void* start,void* end)
{
    char* p;
    p = (char*)PGROUNDUP((uint)start);
    for(;p + PGSIZE <= (char*)end; p += PGSIZE)
        free_page(p);
}

// allocate a page
char*
alloc_page(void)
{
    struct km_node* m;
    m = kmem.h;
    if (m == 0)
        return 0;
    
    if (m->size == PGSIZE)
        kmem.h = m->next;
    else {
        struct km_node* e;
        e = m + PGSIZE;
        e->size = m->size - PGSIZE;
        e->next = m->next;
        kmem.h  = e;
    }

    return (char*)m;
}

// allocate more than a page
// allocate small page first combine them
char*
kalloc(uint size)
{
    struct km_node* m;
    uint s = PGROUNDUP(size);

    if (s == PGSIZE)
        return alloc_page();

    // larger than a page
    struct km_node* n;
    struct km_node* p;
    m = kmem.h;
    n = kmem.h->next;
    p = 0;
    uint v = 0;

    //combine a page
    while (n && m) {
        // is next between
        if ((uint)n + v + n->size == m)
            v += n->size;
        else
        {
            p = m;
            m = m->next;
            n = m->next;
            v = 0;
            continue;
        }
        uint tmp = m->size + v;
        if (tmp == s) {
            if (!p) kmem.h = n->next;
            else p->next = n->next;
            return (char*)n;  
        }
        n = n->next;
    }

    // find enough big page
    m = kmem.h;
    p = 0;
    while(m)
    {
        if (m->size == s) {
            if (p) p->next = m->next;
            break;
        }
        else if (m->size > s) {
            struct km_node* e;
            e = m + s;
            e->size = m->size - s;
            e->next = m->next;
            kmem.h = e;
            return (char*)e;
        }
        p = m;
        m = m->next;
    }

    if (p == 0) kmem.h = m->next;
    return (char*)m;
}

void
kminit1(void* vstart,void* vend)
{
    kmem.h = 0;
    freerange(vstart,vend);
}

void
kminit2(void* vstart,uint size)
{
    kmem.h = 0;
    kfree(PGROUNDUP((uint)vstart),size);
}