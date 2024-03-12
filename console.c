#include "io.h"

#define CRTPORT 0x3d4

// VGA memory address
static ushort *crt = (ushort*)0xb8000;
// static uint pos = 0;

__attribute__ ((__used__)) void 
vgaputc(uchar c) {
    int pos = 0;
    outb(CRTPORT,14);
    //256 一行
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT,15);
    pos |= inb(CRTPORT+1);

    // 换行
    if (c == '\n')
        pos += 80;
    else  if (c == '\b')
        --pos;
    else
        crt[pos++] = c | 0x0700;

    // if ((pos/80) >= 24) {
    //     memmove(crt, crt+80, sizeof(crt[0])*23*80);
    //     pos -= 80;
    //     memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
    // }

    if (pos < 0) 
        pos = 0;
    else if (pos > 80 * 25)
        pos = 0;

    outb(CRTPORT,14);
    outb(CRTPORT+1,pos >> 8);
    outb(CRTPORT,15);
    outb(CRTPORT+1,pos);
    crt[pos] = ' ' | 0x0700;
}


//base 几进制
// void 
// printint(int num,int base) {
//     static char digits[] = "0123456789abcdef";
//     //最大16进制长度数
//     char bufn[16];
//     int i = 0;
//     do {
//         bufn[i++] = digits[num % base];
//     } while((num /= base) != 0);
//     while ( --i >= 0 )
//         vgaputc(bufn[i]);
// }
