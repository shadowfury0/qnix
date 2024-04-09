#include "types.h"
#include "mmu.h"
#include "idt.h"
#include "io.h"

struct gatedesc* idts = (struct gatedesc*)IDT_ADDR;

extern void do_other(void);
extern void do_int0(void);
extern void do_int1(void);
extern void do_int2(void);
extern void do_int3(void);
extern void do_int4(void);
extern void do_int5(void);
extern void do_int6(void);
extern void do_int7(void);
extern void do_int8(void);
extern void do_int9(void);
extern void do_int10(void);
extern void do_int11(void);
extern void do_int12(void);
extern void do_int13(void);
extern void do_int14(void);
extern void do_int16(void);
extern void keyboard_interrupt(void);
extern void rtc_interrupt(void);

extern void system_call(void);

void
reserve_error(void)
{
	panic("reserve error\n");
}

void
divide_error(void)
{
	panic("divied zero error\n");
}

void
nmi_error(void)
{
	panic("nmi error\n");
}

void break_point(long * esp,
		long fs,long es,long ds,
		long ebp,long esi,long edi,
		long edx,long ecx,long ebx,long eax)
{
	int tr;

	// asm ("str %%ax":"=a" (tr):"0" (0));
	vprintf("eax: %x ebx: %x ecx: %x edx: %x\n",
		eax,ebx,ecx,edx);
	vprintf("esi: %x edi: %x ebp: %x esp: %x\n",
		esi,edi,ebp,(long) esp);
	vprintf("eip: %x cs: %x eflags: %x\n",esp[0],esp[1],esp[2]);
}

void
overflow_error(void)
{
	panic("overflow error\n");
}

void
bound_error(void)
{
	panic("bound error\n");
}

void
invalid_code(void)
{
	panic("bound error\n");
}

void 
device_not_available(void)
{
	panic("maybe i dont know\n");
}

void
double_fault(void)
{
	panic("double fault\n");
}

void
coprocessor_segment_overrun(void)
{
	panic("coprocessor segment overrun\n");
}

void
invalid_tss(void)
{
	panic("invalid tss\n");
}

void
segment_not_present(void)
{
	panic("segment not present\n");
}

void
stack_error(void)
{
	panic("stack error\n");
}

void
general_protection(void)
{
	panic("general protection\n");
}

void
page_error(void)
{
	panic("page error\n");
}

void
coprocessor_error(void)
{
	panic("coprocessor error\n");
}

void
init_idt(void)
{
	int i;
    for (i=16;i<256;i++)
       SETGATE(idts[i],SYS_INT,SEG_KCODE << 3,0,0);

	// int 0 - int 15
   	SETGATE(idts[0],SYS_INT,SEG_KCODE << 3,do_int0,0);
   	SETGATE(idts[1],SYS_INT,SEG_KCODE << 3,do_int1,0);
   	SETGATE(idts[2],SYS_INT,SEG_KCODE << 3,do_int2,0);
   	SETGATE(idts[3],SYS_TRAP,SEG_KCODE << 3,do_int3,0);	/* 3 - 5 is trap gate */
   	SETGATE(idts[4],SYS_TRAP,SEG_KCODE << 3,do_int4,0);
   	SETGATE(idts[5],SYS_TRAP,SEG_KCODE << 3,do_int5,0);
   	SETGATE(idts[6],SYS_INT,SEG_KCODE << 3,do_int6,0);
   	SETGATE(idts[7],SYS_INT,SEG_KCODE << 3,do_int7,0);
   	SETGATE(idts[8],SYS_INT,SEG_KCODE << 3,do_int8,0);
   	SETGATE(idts[9],SYS_INT,SEG_KCODE << 3,do_int9,0);
   	SETGATE(idts[0xa],SYS_INT,SEG_KCODE << 3,do_int10,0);
   	SETGATE(idts[0xb],SYS_INT,SEG_KCODE << 3,do_int11,0);
   	SETGATE(idts[0xc],SYS_INT,SEG_KCODE << 3,do_int12,0);
   	SETGATE(idts[0xd],SYS_INT,SEG_KCODE << 3,do_int13,0);
   	SETGATE(idts[0xe],SYS_INT,SEG_KCODE << 3,do_int14,0);
	// keep this interrupt for bios
   	SETGATE(idts[0xf],SYS_INT,SEG_KCODE << 3,do_other,0);
   	SETGATE(idts[0x10],SYS_INT,SEG_KCODE << 3,do_int16,0);

   	SETGATE(idts[0x21],SYS_INT,SEG_KCODE << 3,keyboard_interrupt,0);
	SETGATE(idts[0x28],SYS_INT,SEG_KCODE<<3,rtc_interrupt,0);

	// system call 
	SETGATE(idts[T_SYSCALL],SYS_INT,SEG_KCODE<<3,system_call,0);
	
    lidt(IDT_ADDR,IDT_SIZE);
}

void
init_pic(void)
{	
    outb(PIC_M_CTRL,0x11);    /* Edge trigger mode */
	outb(PIC_M_DATA,0x20);    /* IRQ0-7 mapped to INT20-27 */
	outb(PIC_M_DATA,1 << 2);  /* Connect PIC1 to IRQ2 */
	outb(PIC_M_DATA,0x01);    /* No buffer mode */

	outb(PIC_S_CTRL,0x11); 	  /* Edge trigger mode */
	outb(PIC_S_DATA,0x28); 	  /* IRQ8-15 mapped to INT28-2F */
	outb(PIC_S_DATA,2);    	  /* Connect PIC1 to IRQ2 */
	outb(PIC_S_DATA,0x01); 	  /* No buffer mode */

	// forbidden all interrupt
	outb(PIC_M_DATA,0xff); 
	outb(PIC_S_DATA,0xff);

	/* init keyboard interrupt */
	outb(PIC_M_DATA,0xf9);
	/* init timer interrupt */
	outb(PIC_S_DATA,0xfe);
}

// 暂时放在这里
// send eoi message
void
piceoi()
{
    outb(PIC_M_CTRL,PIC_EOI);
    outb(PIC_S_CTRL,PIC_EOI);
}
