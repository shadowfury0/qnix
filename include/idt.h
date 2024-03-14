#include "type.h"

#define IDT_ADDR        0x7e00  // idt location

#define PIC0_IMR		0x0021
#define PIC1_IMR		0x00a1


// Gate descriptors for interrupts and traps
struct gatedesc {
    ushort off_l;       // low 16 bits of offset in segment
    ushort cs;          // code segment selector
    ushort args : 5;        // # args, 0 for interrupt/trap gates
    ushort rsv1 : 3;        // reserved(should be zero I guess)
    ushort type : 4;        // type(STS_{IG32,TG32})
    ushort s : 1;           // must be 0 (system)
    ushort dpl : 2;         // descriptor(meaning new) privilege level
    ushort p : 1;
    ushort off_h;       // high bits of offset in segment
};

// Gate Type
#define GT_TSS    0x9     // Available 32-bit TSS
#define GT_INT    0xE     // 32-bit Interrupt Gate
#define GT_TRAP   0xF     // 32-bit Trap Gate

#define SETGATE(gate, t, c, off, d)       \
      gate.off_l = (uint)(off) & 0xffff;  \
      gate.cs = (c);                      \
      gate.args = 0;                      \
      gate.rsv1 = 0;                      \
      gate.type = t;                      \
      gate.s = 0;                         \
      gate.dpl = (d);                     \
      gate.p = 1;                         \
      gate.off_h = (uint)(off) >> 16;     
