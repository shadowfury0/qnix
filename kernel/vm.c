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

extern char kend[];

// global gdt 
struct segdesc* kgdt;

void
seginit(void)
{
    if ((kgdt = (struct segdesc*)alloc_page()) == 0)
        panic("alloc gdt table error");
    
    kgdt[SEG_NULL]  = SEG(0,0,0,0);
    kgdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
    kgdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
    // kgdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
    // kgdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

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
        if(!alloc || (pgtab = (int*)alloc_page()) == 0)
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

int*
setupkvm(void)
{
    int* pgdir;
    if ((pgdir = (int*)alloc_page()) == 0)
        return 0;

    memset(pgdir,0,PGSIZE);
    if (P2V(PHYSTOP) > (void*)DEVSPACE)
        panic("PHYSTOP too high");
    
    // first page
    if(mappages(pgdir,0,0,P4MSIZE,PTE_W)||mappages(pgdir,KBASE,0,P4MSIZE,PTE_W))   {
        freevm(pgdir);
        return 0;
    }
    return pgdir;
}

void
kvminit(void)
{
    kpgdir = setupkvm();
    // load cr3
    switchkvm(kpgdir);
    // other pages
    int i;
    uint ps;
    // for (i=1;i<KPSIZE;i++) {
    //     ps = i * P4MSIZE;
    //     kpgdir[KINDEX+i] = (ps) | PTE_W | PTE_PS;

    //     if(mappages(kpgdir,P2V(ps),ps,P4MSIZE,PTE_W))   {
    //         panic("kernel page init error");
    //     }
    //     // freerange((char*)P2V(ps),(char*)P2V(ps + P4MSIZE));
    //     kfree((char*)P2V(ps),P4MSIZE);
    // }
}

void
switchkvm(void* kpgdir)
{
    // switch to the kernel page table
    lcr3(V2P(kpgdir));
}

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(int* pgdir, uint oldsz, uint newsz)
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
            // if(pa == 0)
            //     panic("kfree");
            char* v = P2V(pa);
            if(pa >= PGROUNDUP((uint)kend)) {
                free_page(v);
            }
            *pte = 0;
        }
    }
    return newsz;
}

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(int *pgdir, uint oldsz, uint newsz)
{
    char* mem;
    int*  pte;
    uint  s,pa;
    if (newsz > KBASE)
        return 0;
    else if (newsz < oldsz)
        return oldsz;

    s = PGROUNDUP(oldsz);
    for (;s < newsz; s += PGSIZE) {
        // clean the current page for user
        deallocuvm(pgdir,s+PGSIZE,s);

        mem = alloc_page();
        if (mem == 0) {
            vprintf("allocate out of memory\n");
            deallocuvm(pgdir, newsz, oldsz);
            return 0;
        }
        // clean for the user space to map
        memset(mem,0,PGSIZE);
        // map user space
        if (mappages(pgdir,(char*)s,V2P(mem),PGSIZE,PTE_W|PTE_U)) {
            vprintf("allocate out of memory (2)\n");
            deallocuvm(pgdir, newsz, oldsz);
            free_page(mem);
            return 0;
        }
    }
    return newsz;
}

// load the memory from user space
// user space start from 0
int
loaduvm(int* pgdir,char *addr,uint sz)
{
    if((uint) addr % PGSIZE != 0)
        panic("loaduvm: addr must be page aligned");

    uint i;
    sz = PGROUNDUP(sz);
    for(i = 0; i < sz; i += PGSIZE){
        if(findpage(pgdir, addr+i, 0) == 0)
            panic("loaduvm: address should exist");
        
        memmove(i,addr,PGSIZE);
    }
}

// copy the page table
int*
copypg(int *pgdir)
{
    int* d;
    if (!pgdir)
        return 0;
    
    if((d = (int*)alloc_page()) == 0)
        return 0;
    memcpy(d,pgdir,PGSIZE);
    return d;
}

// free the all page table memory
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
            free_page(f);
        }
    }
    free_page((char*)pgdir);
}