#include "def.h"
#include "idt.h"
#include "io.h"

struct gatedesc* idts = (struct gatedesc*)IDT_ADDR;

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
extern void do_int15(void);
extern void keyboard_interrupt(void);

// print interrupt error message and exit program
void
die(char* str)
{
	vprintf("divied zero error\n");
	panic("interrupt error");
}

void
divide_error(void)
{
	die("divied zero error\n");
}

void
nmi_error(void)
{
	die("nmi error\n");
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
	die("overflow error\n");
}

void
bound_error(void)
{
	die("bound error\n");
}

void
invalid_code(void)
{
	die("bound error\n");
}

void 
device_not_available(void)
{
	die("maybe i dont know\n");
}

void
double_fault(void)
{
	die("double fault\n");
}

void
coprocessor_segment_overrun(void)
{
	die("coprocessor segment overrun\n");
}

void
invalid_tss(void)
{
	die("invalid tss\n");
}

void
segment_not_present(void)
{
	die("segment not present\n");
}

void
stack_error(void)
{
	die("stack error\n");
}

void
general_protection(void)
{
	die("general protection\n");
}

void
page_error(void)
{
	die("page error\n");
}

void
coprocessor_error(void)
{
	die("coprocessor error\n");
}

void
init_idt(void)
{
	int i;
    for (i=16;i<256;i++)
       SETGATE(idts[i],GT_INT,SEG_KCODE << 3,0,0);

	// int 0 - int 15
   	SETGATE(idts[0],GT_INT,SEG_KCODE << 3,do_int0,0);
   	SETGATE(idts[1],GT_INT,SEG_KCODE << 3,do_int1,0);
   	SETGATE(idts[2],GT_INT,SEG_KCODE << 3,do_int2,0);
   	SETGATE(idts[3],GT_TRAP,SEG_KCODE << 3,do_int3,0);	/* 3 - 5 is trap gate */
   	SETGATE(idts[4],GT_TRAP,SEG_KCODE << 3,do_int4,0);
   	SETGATE(idts[5],GT_TRAP,SEG_KCODE << 3,do_int5,0);
   	SETGATE(idts[6],GT_INT,SEG_KCODE << 3,do_int6,0);
   	SETGATE(idts[7],GT_INT,SEG_KCODE << 3,do_int7,0);
   	SETGATE(idts[8],GT_INT,SEG_KCODE << 3,do_int8,0);
   	SETGATE(idts[9],GT_INT,SEG_KCODE << 3,do_int9,0);
   	SETGATE(idts[0xa],GT_INT,SEG_KCODE << 3,do_int10,0);
   	SETGATE(idts[0xb],GT_INT,SEG_KCODE << 3,do_int11,0);
   	SETGATE(idts[0xc],GT_INT,SEG_KCODE << 3,do_int12,0);
   	SETGATE(idts[0xd],GT_INT,SEG_KCODE << 3,do_int13,0);
   	SETGATE(idts[0xe],GT_INT,SEG_KCODE << 3,do_int14,0);
   	SETGATE(idts[0xf],GT_INT,SEG_KCODE << 3,do_int15,0);

   	SETGATE(idts[0x21],GT_INT,SEG_KCODE << 3,keyboard_interrupt,0);

    lidt(IDT_ADDR,IDT_SIZE);
}

void
init_pic(void)
{	
    outb(PIC_M_CTRL,0x11);    /* 边缘触发模式（edge trigger mode） */
	outb(PIC_M_DATA,0x20);    /* IRQ0-7由INT20-27接收 */
	outb(PIC_M_DATA,1 << 2);  /* PIC1由IRQ2相连 */
	outb(PIC_M_DATA,0x01);    /* 无缓冲区模式 */

	outb(PIC_S_CTRL,0x11); 	 /* 边缘触发模式（edge trigger mode） */
	outb(PIC_S_DATA,0x28); 	 /* IRQ8-15由INT28-2f接收 */
	outb(PIC_S_DATA,2);    	 /* PIC1由IRQ2连接 */
	outb(PIC_S_DATA,0x01); 	 /* 无缓冲区模式 */

	// forbidden all interrupt
	outb(PIC_M_DATA,0xff); 
	outb(PIC_S_DATA,0xff);

	outb(PIC_M_DATA,0xf9);     /* 开放PIC1和键盘中断(11111001) */
}

// 暂时放在这里
// send eoi message
void
piceoi()
{
    outb(PIC_M_CTRL,PIC_EOI);
    outb(PIC_S_CTRL,PIC_EOI);
}
