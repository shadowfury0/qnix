#include 	"def.h"
.code16
.globl 	_start
_start:
	xorw    %ax,%ax             # Set %ax to zero
	movw    %ax,%ds             # -> Data Segment
	movw    %ax,%es             # -> Extra Segment
	movw    %ax,%ss             # -> Stack Segment

#开启32位模式
	lgdt    gdtdesc
#跳转之前必须把中断关掉
	cli
	movl    %cr0, %eax
	orl     $CR0_PE, %eax
	movl    %eax, %cr0
	ljmp    $(SEG_KCODE<<3),$start32

.code32
start32:
	movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
	movw    %ax, %ds                # -> DS: Data Segment
	movw    %ax, %es                # -> ES: Extra Segment
	movw    %ax, %ss                # -> SS: Stack Segment
	movw    $0, %ax                 # Zero segments not ready for use
	movw    %ax, %fs                # -> FS
	movw    %ax, %gs                # -> GS	 

# 读取硬盘扇区的函数
	call	bootmain

fin:
	jmp 	fin


# Bootstrap GDT
.p2align 	2
gdt:
	SEG_NULLASM                             # null seg
	SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)   # code seg
	SEG_ASM(STA_W, 0x0, 0xffffffff)         # data seg
gdtdesc:
	.word	(gdtdesc - gdt - 1)		# sizeof(gdt) - 1
	.long 	gdt						# address gdt