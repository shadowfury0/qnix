.DEFAULT_GOAL := all
OBJS = boot.ld boot.h boot.S bootmain.c
CC = gcc
CCOPTS = -O1  -nostdinc -I../include -c -m32  -w
CCOPTS += -fno-pic -fno-pie -no-pie -static -fno-builtin -fno-strict-aliasing -fno-omit-frame-pointer
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
BOOT = 	boot.o bootmain.o 
BOOT_SOURCE = boots.o

#all strategy
all:OBJS
	${CC} boot.S ${CCOPTS} -D__ASSEMBLY__ -o boot.o
	${CC} bootmain.c ${CCOPTS} -o bootmain.o  
	${LD} ${LDOPTS} -e _start -o boots.o -Ttext=0x7c00 ${BOOT} 
	$(OBJCOPY) -O binary boots.o boots.bin
# magic !!!
gdb: CCOPTS += -g
gdb: all
	${OBJDUMP} -d -M att ${BOOT_SOURCE} > boots.asm

clean:
	rm -f *.o ${BOOT_SOURCE} boots.asm boots.bin


.PHONY: clean OBJS gdb all
