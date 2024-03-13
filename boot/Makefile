.DEFAULT_GOAL := all
OBJS = boot.ld boot.h boot.S bootmain.c
CC = gcc
CCOPTS = -O1 -fno-pic -nostdinc -I../include -c -m32  -w
LD = ld
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
BOOT = 	boot.o bootmain.o 
BOOT_SOURCE = bootsource

#all strategy
all:OBJS
	${CC} boot.S ${CCOPTS} -o boot.o
	${CC} bootmain.c ${CCOPTS} -o bootmain.o  
	${LD} ${LDOPTS} -e _start --oformat=binary -o boots.o ${BOOT} -Ttext=0x7c00

# magic !!!
gdb: CCOPTS += -g
gdb: all
	${LD} ${LDOPTS} -T boot.ld -e _start -o ${BOOT_SOURCE} ${BOOT} -Ttext=0x7c00
	${OBJDUMP} -d -M att ${BOOT_SOURCE} > boots.asm

clean:
	rm -f *.o ${BOOT_SOURCE} boots.asm


.PHONY: clean OBJS gdb
