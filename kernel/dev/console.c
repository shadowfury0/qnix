#include "types.h"
#include "io.h"

#define CRTPORT 0x3d4

// VGA memory address
static ushort *crt = (ushort*)0xb8000;
// static int pos = 0;

void 
vgaputc(uchar c) 
{
    int pos = 0;
    outb(CRTPORT,14);
    //256 一行
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT,15);
    pos |= inb(CRTPORT+1);

    // 换行
    if (c == '\n')
        pos += 80 - (pos % 80);
    else  if (c == '\b')
        --pos;
    else  if (c == '\t')
        pos += 4;
    else
        crt[pos++] = c | 0x0700;

    if ((pos/80) >= 24) {
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
        pos -= 80;
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
    }

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
void 
printint(uint num,int base) 
{
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

// modify later
void
vprintf(char* str,...) 
{
    if (str == 0)
        return;

    uint *argp;
    char* s;
    int i,c;
    // represent ...
    argp = (uint*)(void*)(&str + 1);
    for (i = 0; (c = str[i] & 0xff ) != 0; i++ ) {
        if (c != '%') {
            vgaputc(c);
            continue;
        }
        c = str[++i] & 0xff;
        switch (c) {
        case 'd':
            printint(*argp++,10);
            break;
        case 'x':
        case 'p':
            printint(*argp++,16);
            break;
        case 's':
            if ( (s = (char*)*argp++) == 0) 
                s = "(null)";
            for(;*s;s++)
                vgaputc(*s);
            break;
        case '%':
            vgaputc('%');
            break;
        default:
            vgaputc('%');
            vgaputc(c);
            break;
        }
    }
}