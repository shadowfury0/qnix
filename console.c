#include "io.h"
// VGA memory address
static ushort *crt = (ushort*)0xb8000;
static int pos = 0;
void vgaputc(int c) {
    // int pos;
    // outb(CRTPORT,14);
    // //256 一行
    // pos = inb(CRTPORT+1) << 8;
    // outb(CRTPORT,15);
    // pos |= inb(CRTPORT+1);

    if (pos < 0 ) 
        pos = 0;
    else if ( pos > 80 * 25 )
        pos = 0;

    //换行
    if (c == '\n')
        pos += 80 - pos % 80;
    else if (c == '\b')
        pos--;
    else
        crt[pos++] = (c&0xff) | 0x0700;

    // outb(CRTPORT,14);
    // outb(CRTPORT+1,pos >> 8);
    // outb(CRTPORT,15);
    // outb(CRTPORT+1,pos);

    crt[pos] = ' ' | 0x0700;
}

//base 几进制
void printint(int num,int base) {
    static char digits[] = "0123456789abcdef";

    //最大16进制长度数
    char bufn[16];

    int i = 0;
    do {
        bufn[i++] = digits[num % base];
    } while((num /= base) != 0);


    while ( --i >= 0 )
        vgaputc(bufn[i]);
}

