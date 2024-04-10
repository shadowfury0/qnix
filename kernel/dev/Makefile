.DEFAULT_GOAL := all
CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../../include  -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump

OBJS = 	console.c\
		hd.c\
		kyb.c\
		rtc.c\
	
all:OBJS
	${CC} console.c ${CCOPTS} -o console.o
	${CC} hd.c ${CCOPTS} -o hd.o
	${CC} kyb.c ${CCOPTS} -o kyb.o
	${CC} rtc.c ${CCOPTS} -o rtc.o

gdb: CCOPTS += -g
gdb: all

clean:
	rm -f *.o


.PHONY: clean OBJS gdb all
