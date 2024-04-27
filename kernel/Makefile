.DEFAULT_GOAL := all
OBJS = 	kernel.ld\
		cpu.c\
		idt.S\
		main.c\
		kalloc.c\
		kmain.S\
		memory.c\
		panic.c\
		proc.c\
		string.c\
		swtch.S\
		sys.S\
		syscall.c\
		sysproc.c\
		trap.c\
		umain.S\
		vm.c\

CC = gcc
CCOPTS = -O1 -fno-pic -fno-stack-protector -nostdinc -I../include  -c -m32  -w
LD = ld
KERNEL_SOURCE = kernelsource
LDOPTS = -m elf_i386 -N 
OBJCOPY = objcopy
OBJDUMP = objdump
KERNEL	 =  cpu.o\
			idt.o\
			main.o\
			kalloc.o\
			kmain.o\
			memory.o\
			panic.o\
			proc.o\
			string.o\
			swtch.o\
			sys.o\
			syscall.o\
			sysproc.o\
			trap.o\
			umain.o\
			vm.o\
			dev/console.o\
			dev/ide.o\
			dev/kyb.o\
			dev/rtc.o\
			fs/exec.o\
			fs/fat.o\
			fs/fs.o\

#all strategy
compile:
	${CC} cpu.c ${CCOPTS} -o cpu.o
	${CC} idt.S ${CCOPTS} -D__ASSEMBLY__ -o idt.o
	${CC} main.c ${CCOPTS} -o main.o
	${CC} kalloc.c ${CCOPTS} -o kalloc.o
	${CC} kmain.S ${CCOPTS} -D__ASSEMBLY__ -o kmain.o
	${CC} memory.c ${CCOPTS} -o memory.o
	${CC} panic.c ${CCOPTS} -o panic.o
	${CC} proc.c ${CCOPTS} -o proc.o
	${CC} string.c ${CCOPTS} -o string.o
	${CC} swtch.S ${CCOPTS} -o swtch.o
	${CC} sys.S ${CCOPTS} -o sys.o
	${CC} syscall.c ${CCOPTS} -o syscall.o
	${CC} sysproc.c ${CCOPTS} -o sysproc.o
	${CC} trap.c ${CCOPTS} -o trap.o
	${CC} umain.S ${CCOPTS} -D__ASSEMBLY__ -o umain.o
	${CC} vm.c ${CCOPTS} -o vm.o

all:OBJS compile
	${MAKE} -C dev
	${MAKE} -C fs
	${LD} ${LDOPTS} -T kernel.ld -e _start -o kernel.o ${KERNEL}

# magic !!!
gdb: CCOPTS += -g
gdb:OBJS compile
	${MAKE} -C fs gdb
	${MAKE} -C dev gdb
	${LD} ${LDOPTS} -T kernel.ld -e _start -o ${KERNEL_SOURCE} ${KERNEL}
	${OBJCOPY} --strip-debug ${KERNEL_SOURCE} kernel.o 
	${OBJDUMP} -d -M att kernel.o > kernel.asm

clean:
	${MAKE} -C fs clean
	${MAKE} -C dev clean
	rm -f *.o kernel.asm ${KERNEL_SOURCE}


.PHONY: clean OBJS gdb all
