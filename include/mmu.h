// memory management unit (MMU).

#define KSTACKSIZE  4096    //kernel stack size

// Control Register flags
#define CR0_PE          0x00000001      // Protection Enable
#define CR0_WP          0x00010000      // Write Protect
#define CR0_PG          0x80000000      // Paging
// Page table/directory flags.
#define PTE_P           0x001   // Present
#define PTE_W           0x002   // Writeable
#define PTE_U           0x004   // User
#define PTE_PS          0x080   // Page Size
// Address in page table or page directory entry
#define PTE_ADDR(pte)   ((uint)(pte) & ~0xFFF)
#define PTE_FLAGS(pte)  ((uint)(pte) &  0xFFF)

// no use
#define PTSHIFT         12      // offset of Page Table in a linear address
#define PDSHIFT         22      // offset of Page Directory in a linear address

#define PGSIZE          4096            // bytes mapped by a page
#define CR4_PSE         0x00000010      // Page size extension

#define PGROUNDUP(sz)  (((sz)+PGSIZE-1) & ~(PGSIZE-1))
#define PGROUNDDOWN(a) (((a)) & ~(PGSIZE-1))

// kernel base address
#define KBASE   0x80000000
#define V2P(a) (((uint) (a)) - KBASE)
#define V2PS(a) ((a) - KBASE)
#define P2V(a) ((void *)(((char *) (a)) + KBASE))
#define P2VS(a) ((a) + KBASE)


// may be 256 M is enough total 512 M , but point to virtual memory
#define PHYSTOP     0xE000000       // Kernel start physical memory
// is larger than 512M maybe no use but 80386 reserve this address
#define DEVSPACE    0xFE000000      // Other devices are at high addresses