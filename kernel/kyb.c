#include "types.h"
#include "kyb.h"
#include "io.h"
#include "tty.h"

volatile struct tty_queue q;
volatile uchar shift_pressed;
volatile uchar alt_pressed;
volatile uchar ctrl_pressed;

static	uchar  key_table[] = {
	0,0x1b,'1','2',			/* 00-03 s0 esc 1 2 */
	'3','4','5','6',		/* 04-07 3 4 5 6 */
	'7','8','9','0',		/* 08-0B 7 8 9 0 */
	'-','=',0x08,0x0b,		/* 0C-0F - = bs tab */
	'q','w','e','r',		/* 10-13 q w e r */
	't','y','u','i',		/* 14-17 t y u i */
	'o','p','[',']',		/* 18-1B o p [ ] */
	0x0a,0,'a','s',			/* 1C-1F enter ctrl a s */
	'd','f','g','h',		/* 20-23 d f g h */
	'j','k','l',';',		/* 24-27 j k l ; */
	'\'','`',0,'\\', 		/* 28-2B ' ` lshift \  */
	'z','x','c','v', 		/* 2C-2F z x c v */
	'b','n','m',',', 		/* 30-33 b n m , */
	'.','/',0,'*', 			/* 34-37 . - rshift * */
	0,0x20,0,0, 			/* 38-3B alt sp caps f1 */
	0,0,0,0, 				/* 3C-3F f2 f3 f4 f5 */
	0,0,0,0, 				/* 40-43 f6 f7 f8 f9 */
	0,0,0,'7', 				/* 44-47 f10 num scr kp7 */
	'8','9','-','4', 		/* 48-4B kp8 kp9 kp- kp4 */
	'5','6','+','1', 		/* 4C-4F kp5 kp6 kp+ kp1 */
	'2','3','0','.', 		/* 50-53 kp2 kp3 kp0 kp. */
	0,0,0,0, 				/* 54-57 null null null f11 */
	0						/* 58 f12*/
};

static	uchar  shift_table[] = {
	0,0x1b,'!','@',			/* 00-03 s0 esc ! @ */
	'#','$','%','^',		/* 04-07 # $ % ^ */
	'&','*','(',')',		/* 08-0B & * ( ) */
	'_','+',0x08,0x0b,		/* 0C-0F _ + bs tab */
	'Q','W','E','R',		/* 10-13 q w e r */
	'T','Y','U','I',		/* 14-17 t y u i */
	'O','P','{','}',		/* 18-1B o p { } */
	0x0a,0,'A','S',			/* 1C-1F enter ctrl a s */
	'D','F','G','H',		/* 20-23 d f g h */
	'J','K','L',':',		/* 24-27 j k l ; */
	'"','~',0,'|', 			/* 28-2B " ~ lshift |  */
	'Z','X','C','V', 		/* 2C-2F z x c v */
	'B','N','M','<', 		/* 30-33 b n m < */
	'>','?',0,'*', 			/* 34-37 > ? rshift * */
	0,0x20,0,0, 			/* 38-3B alt sp caps f1 */
	0,0,0,0, 				/* 3C-3F f2 f3 f4 f5 */
	0,0,0,0, 				/* 40-43 f6 f7 f8 f9 */
	0,0,0,'7', 				/* 44-47 f10 num scr kp7 */
	'8','9','-','4', 		/* 48-4B kp8 kp9 kp- kp4 */
	'5','6','+','1', 		/* 4C-4F kp5 kp6 kp+ kp1 */
	'2','3','0','.', 		/* 50-53 kp2 kp3 kp0 kp. */
	0,0,0,0, 				/* 54-57 null null null f11 */
	0						/* 58 f12*/
};

void 
wait_kybc_sendready(void)
{
	// waiting for the keyboard control circuit to be ready
	for (;;)
		if ((inb(KB_STATP) & KEYSTA_SEND_NOTREADY) == 0 ) break;
}

void 
init_keyboard(void)
{
	// initialize keyboard control circuit
	wait_kybc_sendready();
	outb(KB_STATP, KYBCMD_WRITE_MODE);
	wait_kybc_sendready();
	outb(KB_STATP, KYBC_MODE);

	//init tty queue
	TTY_Q_INIT(q);
	shift_pressed = false;
	alt_pressed = false;
	ctrl_pressed = false;
}

void
keygetc(void)
{
	cli();
	if (!TTY_Q_FULL(q))
    	TTY_Q_PUT(q,inb(KB_DATAP));
	// keyputc();
    piceoi();
	sti();
}

// key command put to console
void
keyputc(void)
{
	uchar val;
	if (!TTY_Q_EMPTY(q)) {
		TTY_Q_GET(q,val);

		// determine shift key is pressed
		if (val == 0x2a || val == 0x36) shift_pressed = true;
		else if (val == 0xaa || val == 0xb6) shift_pressed = false;
		// determine control key is pressed
		else if (val == 0x1d) ctrl_pressed = true;
		else if (val == 0x9d) ctrl_pressed = false;
		// determine alt key is pressed
		else if (val == 0x38) alt_pressed = true;
		else if (val == 0xb8) alt_pressed = false;

		if (val < sizeof(key_table)) {
			if (shift_pressed) val=shift_table[val];
			else val=key_table[val];

			if (val) vgaputc(val);
		}
	}
}
