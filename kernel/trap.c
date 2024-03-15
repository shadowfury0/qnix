#include "def.h"
#include "idt.h"
#include "io.h"

struct gatedesc* idts = (struct gatedesc*)IDT_ADDR;

extern void divide_error(void);

extern void keyboard_interrupt(void);

void
init_idt(void)
{
    int i;
    for (i=0;i<256;i++)
       SETGATE(idts[i],GT_INT,SEG_KCODE << 3,0,0);

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
void
piceoi()
{
	// send eoi message
    outb(PIC_M_CTRL,PIC_EOI);
    outb(PIC_S_CTRL,PIC_EOI);
}
