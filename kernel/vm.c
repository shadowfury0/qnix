#include "io.h"
#include "mmu.h"
// kernel page directory
extern int* pgdir[];

// pages allocate
// static int*
// palloc(void* vs,void* ve)
// {
//     char* s = vs;
//     while (s < ve) {
//         if ((s = kalloc()) == 0)
//             return 1;
//         s += PGSIZE;
//     }
//     return 0;
// }

// int*
// setupkvm(void)
// {
    // int*  pgdir;
    // if ((pgdir = (int*)kalloc()) == 0)
    //     return 0;

    // memset(pgdir,0,PGSIZE);
    // if (P2V(KPSTART) > (void*)DEVSPACE)
    //     panic("kernel start is too high");
    
    // palloc();

    // return pgdir;
// }

void
kvmalloc(void)
{
    // kpgdir = setupkvm();
    lcr3(V2P(pgdir));
}
