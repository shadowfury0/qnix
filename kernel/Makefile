.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		console.c\
		cpu.c\
		exec.c\
		idt.S\
		main.c\
		kalloc.c\
		kmain.S\
		kyb.c\
		memory.c\
		panic.c\
		proc.c\
		rtc.c\
		swtch.S\
		trap.c\
		usr.c\
		vm.c\

CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../include -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  console.o\
			cpu.o\
			exec.o\
			idt.o\
			main.o\
			kalloc.o\
			kmain.o\
			kyb.o\
			memory.o\
			panic.o\
			proc.o\
			rtc.o\
			swtch.o\
			trap.o\
			usr.o\
			vm.o\


#all strategy
compile:
	${CC} console.c ${CCOPTS} -o console.o
	${CC} cpu.c ${CCOPTS} -o cpu.o
	${CC} exec.c ${CCOPTS} -o exec.o
	${CC} idt.S ${CCOPTS} -D__ASSEMBLY__ -o idt.o
	${CC} main.c ${CCOPTS} -o main.o
	${CC} kalloc.c ${CCOPTS} -o kalloc.o
	${CC} kmain.S ${CCOPTS} -D__ASSEMBLY__ -o kmain.o
	${CC} kyb.c ${CCOPTS} -o kyb.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} panic.c ${CCOPTS} -o panic.o
	${CC} proc.c ${CCOPTS} -o proc.o
	${CC} rtc.c ${CCOPTS} -o rtc.o
	${CC} swtch.S ${CCOPTS} -o swtch.o
	${CC} trap.c ${CCOPTS} -o trap.o
	${CC} usr.c ${CCOPTS} -o usr.o
	${CC} vm.c ${CCOPTS} -o vm.o

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
