#include "type.h"

#define IDT_ADDR        0x7e00  // idt location
#define IDT_SIZE        256 * 80

// Gate descriptors for interrupts and traps
struct gatedesc {
    unsigned short off_l;       // low 16 bits of offset in segment
    unsigned short cs;          // code segment selector
    unsigned short args : 5;        // # args, 0 for interrupt/trap gates
    unsigned short rsv1 : 3;        // reserved(should be zero I guess)
    unsigned short type : 4;        // type(STS_{IG32,TG32})
    unsigned short s : 1;           // must be 0 (system)
    unsigned short dpl : 2;         // descriptor(meaning new) privilege level
    unsigned short p : 1;
    unsigned short off_h;       // high bits of offset in segment
};


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
