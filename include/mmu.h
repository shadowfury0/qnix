// memory management unit (MMU).
#define SEG_NULLASM                                             \
        .word 0, 0;                                             \
        .byte 0, 0, 0, 0

// The 0xC0 means the limit is in 4096-byte units
// and (for executable segments) 32-bit mode.
#define SEG_ASM(type,base,lim)                                  \
        .word (((lim) >> 12) & 0xffff), ((base) & 0xffff);      \
        .byte (((base) >> 16) & 0xff), (0x90 | (type)),         \
                (0xC0 | (((lim) >> 28) & 0xf)), (((base) >> 24) & 0xff)

// Eflags register
#define FL_IF           0x00000200      // Interrupt Enable

#define STA_X           0x8       // Executable segment
#define STA_W           0x2       // Writeable (non-executable segments)
#define STA_R           0x2       // Readable (executable segments)

#define DPL_USER        0x3     // User DPL

#define SEG_NULL        0  // first 
#define SEG_KCODE       1  // kernel code
#define SEG_KDATA       2  // kernel data+stack
// #define SEG_UCODE       3  // kernel data+stack
// #define SEG_UDATA       4  // kernel data+stack
#define SEG_FIRST       3

#ifndef __ASSEMBLY__
struct segdesc {
    uint lim_15_0 : 16;  // Low bits of segment limit
    uint base_15_0 : 16; // Low bits of segment base address
    uint base_23_16 : 8; // Middle bits of segment base address
    uint type : 4;       // Segment type (see STS_ constants)
    uint s : 1;          // 0 = system, 1 = application
    uint dpl : 2;        // Descriptor Privilege Level
    uint p : 1;          // Present
    uint lim_19_16 : 4;  // High bits of segment limit
    uint avl : 1;        // Unused (available for software use)
    uint rsv1 : 1;       // Reserved
    uint db : 1;         // 0 = 16-bit segment, 1 = 32-bit segment
    uint g : 1;          // Granularity: limit scaled by 4K when set
    uint base_31_24 : 8; // High bits of segment base address
};

// Normal segment
#define SEG(type, base, lim, dpl) (struct segdesc)\
{ ((uint)(lim) >> 12) & 0xffff, ((uint)(base) & 0xffff),\
((uint)(base) >> 16) & 0xff, type, 1, dpl, 1,\
(((uint)(lim) >> 28) & 0xf), 0, 0, 1, 1, (((uint)(base) >> 24) & 0xff) }

#endif

// ----------------------------------------------------------------------------
// Control Register flags
#define CR0_PE          0x00000001      // Protection Enable
//
// +--------10------+-------10-------+---------12----------+
// | Page Directory |   Page Table   | Offset within Page  |
// |      Index     |      Index     |                     |
// +----------------+----------------+---------------------+
//  \--- PDX(va) --/ \--- PTX(va) --/

#define KSTACKSIZE      4096    //kernel stack size
#define PGTSIZE         1024    //page table size
// Control Register flags
#define CR0_PE          0x00000001      // Protection Enable
#define CR0_WP          0x00010000      // Write Protect
#define CR0_PG          0x80000000      // Paging
// Page table/directory flags.
#define PTE_P           0x001   // Present
#define PTE_W           0x002   // Writeable
#define PTE_U           0x004   // User
#define PTE_PS          0x080   // Page Size 4MB
// Address in page table or page directory entry
#define PTE_ADDR(pte)   ((uint)(pte) & ~0xFFF)
#define PTE_FLAGS(pte)  ((uint)(pte) &  0xFFF)

#define PTSHIFT         12      // offset of Page Table in a linear address
#define PDSHIFT         22      // offset of Page Directory in a linear address
#define PTX(va)         (((uint)(va) >> PTSHIFT) & 0x3FF)
#define PDX(va)         (((uint)(va) >> PDSHIFT) & 0x3FF)
// construct virtual address from indexes and offset
#define PGADDR(d, t, o) ((uint)((d) << PDSHIFT | (t) << PTSHIFT | (o)))

#define PGSIZE          4096            // bytes mapped by a page
#define P4MSIZE         0x400000        // 4MB page 
#define CR4_PSE         0x00000010      // Page size extension

#define PGROUNDUP(sz)  (((sz)+PGSIZE-1) & ~(PGSIZE-1))
#define PGROUNDDOWN(a) (((a)) & ~(PGSIZE-1))

// may be 224 M is enough total 512 M , but point to virtual memory
#define PHYSTOP         0xE000000       // Top physical memory
// is larger than 512M maybe no use but 80386 reserve this address
#define DEVSPACE        0xFE000000      // Other devices are at high addresses
#define IOSPACE         0x100000        // IO SPACE

// kernel base address
#define KPSIZE          6
#define KBASE           0x80000000
#define KINDEX          (KBASE>>PDSHIFT)
#define KLINK           (KBASE + IOSPACE)
#define V2P(a)          (((uint) (a)) - KBASE)
#define V2PS(a)         ((a) - KBASE)
#define P2V(a)          ((void *)(((char *) (a)) + KBASE))
#define P2VS(a)         ((a) + KBASE)

// number of elements in fixed-size array
#define NELEM(x)        (sizeof(x)/sizeof((x)[0]))

// ----------------------------------------------------------------------------

#define IDT_ADDR        0x7e00  // idt location
#define IDT_SIZE        256 * 8

#define PIC_M_CTRL      0x20
#define PIC_M_DATA      0x21 
#define PIC_S_CTRL      0xa0
#define PIC_S_DATA      0xa1

#define PIC_EOI         0x20

#define SYS_TSS         0x9     // Available 32-bit TSS
#define SYS_INT         0xE     // 32-bit Interrupt Gate
#define SYS_TRAP        0xF     // 32-bit Trap Gate

#ifndef __ASSEMBLY__
// Gate descriptors for interrupts and traps
struct gatedesc {
        ushort off_l;       // low 16 bits of offset in segment
        ushort cs;          // code segment selector
        ushort args : 5;    // # args, 0 for interrupt/trap gates
        ushort rsv1 : 3;    // reserved(should be zero I guess)
        ushort type : 4;    // type(STS_{IG32,TG32})
        ushort s : 1;       // must be 0 (system)
        ushort dpl : 2;     // descriptor(meaning new) privilege level
        ushort p : 1;
        ushort off_h;       // high bits of offset in segment
};

#define SETGATE(gate, t, c, off, d){      \
      gate.off_l = (uint)(off) & 0xffff;  \
      gate.cs = (c);                      \
      gate.args = 0;                      \
      gate.rsv1 = 0;                      \
      gate.type = t;                      \
      gate.s = 0;                         \
      gate.dpl = (d);                     \
      gate.p = 1;                         \
      gate.off_h = (uint)(off) >> 16;     \
}

#endif