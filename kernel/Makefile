.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		idt.S\
		kmain.S\
		panic.c\
		kalloc.c\
		init.c\
		trap.c\
		cpu.c\
		kyb.c\
		vm.c\
		memory.c\
		console.c\

CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../include -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  kmain.o\
			panic.o\
			init.o\
			kalloc.o\
			idt.o\
			trap.o\
			kyb.o\
			cpu.o\
			memory.o\
			console.o\
			# vm.o			

#all strategy
compile:
	${CC} idt.S ${CCOPTS} -o idt.o
	${CC} kmain.S ${CCOPTS} -o kmain.o
	${CC} panic.c ${CCOPTS} -o panic.o
	${CC} kalloc.c ${CCOPTS} -o kalloc.o
	${CC} init.c ${CCOPTS} -o init.o
	${CC} trap.c ${CCOPTS} -o trap.o
	${CC} vm.c ${CCOPTS} -o vm.o
	${CC} cpu.c ${CCOPTS} -o cpu.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} kyb.c ${CCOPTS} -o kyb.o
	${CC} console.c ${CCOPTS} -o console.o

all:OBJS compile
	${LD} ${LDOPTS} -T kernel.ld -e _start -o kernel.o ${KERNEL}

# magic !!!
gdb: CCOPTS += -g
gdb:compile
	${LD} ${LDOPTS} -T kernel.ld -e _start -o ${KERNEL_SOURCE} ${KERNEL}
	${OBJCOPY} --strip-debug ${KERNEL_SOURCE} kernel.o 
	${OBJDUMP} -d -M att kernel.o > kernel.asm

clean:
	rm -f *.o kernel.asm ${KERNEL_SOURCE}


.PHONY: clean OBJS gdb all
