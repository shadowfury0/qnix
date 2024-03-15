#include "def.h"
#include "kyb.h"
#include "io.h"

volatile uchar value;

// 键盘初始化
void 
wait_kybc_sendready(void)
{
	/* 等待键盘控制电路准备完毕 */
	for (;;)
		if ((inb(KB_STATP) & KEYSTA_SEND_NOTREADY) == 0 ) break;
}

void 
init_keyboard(void)
{
	/* 初始化键盘控制电路 */
	wait_kybc_sendready();
	outb(KB_STATP, KYBCMD_WRITE_MODE);
	wait_kybc_sendready();
	outb(KB_STATP, KYBC_MODE);
}

void
keygetc(void)
{
    value = inb(KB_DATAP);
    piceoi();
}