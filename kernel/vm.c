#include "types.h"
#include "io.h"
#include "mmu.h"

// extern  char data[];
// kernel page directory

// static  struct kmap {
//     void*   va;
//     uint    ps;
//     uint    pe;
//     int     pte;
// } km[] = {
//     {   (void*)KBASE,   0,          IOSPACE,    PTE_W    },
//     {   (void*)KLINK,   V2P(KLINK), V2P(data),  0        },
//     {   (void*)data,    V2P(data),  PHYSTOP,    PTE_W    },
//     {   (void*)DEVSPACE,DEVSPACE,   0,          PTE_W    },
// };

// kernel page directory
int* kpgdir;

// global gdt 
struct segdesc* kgdt;

void
seginit(void)
{
    if ((kgdt = (struct segdesc*)kalloc()) == 0)
        panic("alloc gdt table error");
    
    kgdt[SEG_NULL]  = SEG(0,0,0,0);
    kgdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
    kgdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
    // gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
    // gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

    // alloc 4096 size
    lgdt(kgdt,PGSIZE);
}

// find the page in pgdir if not found create a page in pgdir
static int*
findpage(int* pgdir, const void *va, int alloc)
{
    int *pde;
    int *pgtab;

    pde = &pgdir[PDX(va)];
    if(*pde & PTE_P){
        pgtab = (int*)P2V(PTE_ADDR(*pde));
    } else {
        if(!alloc || (pgtab = (int*)kalloc()) == 0)
            return 0;
        memset(pgtab, 0, PGSIZE);
        *pde = V2P(pgtab) | PTE_P | PTE_U | PTE_W;
    }
    return &pgtab[PTX(va)];
}

static int
mappages(int *pgdir, void *va, uint pa,uint size, int perm)
{
    char *s, *e;
    int *pte;

    s = (char*)PGROUNDDOWN((uint)va);
    e = (char*)PGROUNDDOWN(((uint)va) + size - 1);
    for(;;){
        if((pte = findpage(pgdir, s, 1)) == 0)
            return 1;
        if(*pte & PTE_P)
            panic("remap");
        *pte = pa | perm | PTE_P;
        if(s == e)
            break;
        s += PGSIZE;
        pa += PGSIZE;
    }
    return 0;
}

void
kvminit(void)
{
    int i;
    int ps;
    int*  kpgdir;
    if ((kpgdir = (int*)kalloc()) == 0)
        return 0;

    memset(kpgdir,0,PGSIZE);
    if (P2V(PHYSTOP) > (void*)DEVSPACE)
        panic("kernel start is too high");
    
    // first page
    if(mappages(kpgdir,0,0,P4MSIZE,PTE_W) || mappages(kpgdir,KBASE,0,P4MSIZE,PTE_W))   {
        panic("kernel page init error");
    }
    // load cr3
    lcr3(V2P(kpgdir));

    // other pages
    for (i=1;i<KPSIZE;i++) {
        ps = i * P4MSIZE;
        kpgdir[i] = (ps) | PTE_W | PTE_PS;
        kpgdir[KINDEX+i] = (ps) | PTE_W | PTE_PS;

        if(mappages(kpgdir,ps,ps,P4MSIZE,PTE_W) || mappages(kpgdir,P2V(ps),ps,P4MSIZE,PTE_W))   {
            panic("kernel page init error");
        }

        freerange((char*)P2V(ps),(char*)P2V(ps + P4MSIZE));
    }
}

int
deallocvm(int* pgdir, uint oldsz, uint newsz)
{
    int* pte;
    uint a, pa;

    if(newsz >= oldsz)
        return oldsz;

    a = PGROUNDUP(newsz);
    for(; a  < oldsz; a += PGSIZE) {
        pte = findpage(pgdir, (char*)a, 0);
        if(!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if((*pte & PTE_P) != 0) {
            pa = PTE_ADDR(*pte);
            if(pa == 0)
                panic("kfree");
            char *v = P2V(pa);
            kfree(v);
            *pte = 0;
        }
    }
    return newsz;
}

int
allocvm(int *pgdir, uint oldsz, uint newsz)
{
    char* mem;
    uint  s;
    if (newsz > KBASE)
        return 0;
    else if (newsz < oldsz)
        return oldsz;

    s = PGROUNDUP(newsz);
    for (;s < newsz; s += PGSIZE) {
        if ((mem = kalloc() == 0)) {
            vprintf("allocate out of memory\n");
            deallocvm(pgdir, newsz, oldsz);
            return 0;
        }
        memset(mem,0,PGSIZE);
        if (mappages(pgdir,(char*)s,V2P(mem),PGSIZE,PTE_W|PTE_U)) {
            vprintf("allocate out of memory (2)\n");
            deallocvm(pgdir, newsz, oldsz);
            kfree(mem);
            return 0;
        }
    }
    return newsz;
}

void
freevm(int* pgdir)
{
    if (pgdir == 0)
        panic("freevm : pgdir error");
    // deallocvm(pgdir, KBASE, 0);
    uint  i;
    for (i=0;i<PGTSIZE;i++) {
        if (pgdir[i] & PTE_P) {
            char* f = P2V(PTE_ADDR(pgdir[i]));
            kfree(f);
        }
    }
    kfree((char*)pgdir);
}
