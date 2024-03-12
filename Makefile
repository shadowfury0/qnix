.DEFAULT_GOAL := all

MAGIC = echo -ne '\x55\xAA' | dd of=${OS_IMG} bs=1 seek=510 conv=notrunc
QEMU = qemu-system-i386
OS_IMG = qos.img
QEMUOPTS = -nographic -drive file=${OS_IMG},index=0,media=disk,format=raw -m 128 -smp ${CPUS}
CPUS = 1
GDBPORT = 2500
BOCHS	= 	bochs -f bochsrc.bxrc

all:
	${MAKE} -C include
	${MAKE} -C boot
	${MAKE} -C kernel
	dd if=boot/boots.o of=${OS_IMG} bs=512 conv=notrunc
	dd if=kernel/kernel.o of=${OS_IMG} bs=512 seek=1 conv=notrunc
	${MAGIC}

gdb: CCOPTS += -g
gdb:all

bochs-img: bochsrc.bxrc
ifneq ($(wildcard ${OS_IMG}),)
	rm -f ${OS_IMG}
endif
	bximage -mode=create -hd=10 -imgmode=flat -q ${OS_IMG}
# bximage -mode=create -fd=1.44M -imgmode=flat -q ${OS_IMG}

bochs: bochs-img all
	${BOCHS} -q 'gdbstub: enabled=0'
bochs-gdb: bochs-img gdb
	${BOCHS}

qemu: all
	${QEMU} ${QEMUOPTS}
qemu-gdb: gdb
	${QEMU} -S ${QEMUOPTS} -gdb tcp::$(GDBPORT)
qemu-vnc: all
	${QEMU} ${OS_IMG} -vnc 192.168.88.128:5900

#use this command with bochs-gdb
debug:
	gdb -ex "target extended-remote localhost:${GDBPORT}"  -ex "file boot/bootsource"
# -ex "file kernel.o"

clean:
	${MAKE} -C boot clean
	${MAKE} -C kernel clean
	rm -f *.tags *.log qos.img

.PHONY: clean bochs-img gdb bochsrc.bxrc