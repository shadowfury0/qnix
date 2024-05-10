#include "types.h"
#include "io.h"
#include "console.h"

#define CRTPORT 0x3d4

// VGA memory address
static ushort *crt = (ushort*)0xb8000;
// static int pos = 0;

void 
vgaputc(uchar c,uchar t) 
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
        crt[pos++] = c | (t << 8);

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

// default 
void
info(uchar c)
{
    vgaputc(c,VGA_COLOR_LIGHT_GREY);
}

void
error(uchar c)
{
    vgaputc(c,VGA_COLOR_RED);
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
        info(bufn[i]);
}

// modify later
void
vprintf(char* str,...) 
{
    if (str == 0)
        return;

    uint *argp;
    char* s;
    int i,c,w;
    // represent ...
    argp = (uint*)(void*)(&str + 1);
    for (i = 0; (c = str[i] & 0xff ) != 0; i++ ) {
        if (c != '%') {
            info(c);
            continue;
        }
        c = str[++i] & 0xff;

        // initialize zero
        w = 0; 
        // 检查是否有宽度字段
        while (c >= '0' && c <= '9') {
            w = w * 10 + (c - '0');
            c = str[++i] & 0xff;
        }

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

            if (w == 0) {
                for(;*s;s++)
                    info(*s);
            } else {
                // fill the blank right side  (left aligned)
                int len = 0;
                for (; *s && len < w; s++, len++)
                    info(*s);
                while (len < w) {
                    info(' ');
                    len++;
                }
            }
            break;
        case '%':
            info('%');
            break;
        default:
            info('%');
            info(c);
            break;
        }
    }
}

<<<<<<< HEAD
volatile int
sys_printf(int arg)
{
    vprintf("%d \n",arg);
=======
int
sys_printf(int arg)
{
    vprintf("%d  \n",arg);
>>>>>>> 908ebe526930f5c722e4a4d266951b309b059a3d
    return 0;
}