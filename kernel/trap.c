#include "boot.h"
#include "idt.h"
#include "io.h"


struct gatedesc* idts = (struct gatedesc*)IDT_ADDR;

void
init_idt(void)
{
    int i;
    for (i=0;i<256;i++)
       SETGATE(idts[i],GT_INT,(SEG_KCODE << 3),0,0);

    lidt(IDT_ADDR,256);

    outb(PIC0_IMR,0xff);
	outb(PIC1_IMR,0xff);   
}