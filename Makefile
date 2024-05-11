.DEFAULT_GOAL := all

MAGIC = $(shell ./magic.sh)
QEMU = qemu-system-i386
OS_IMG = qos.img
QEMUOPTS =  -drive file=${OS_IMG},media=disk,format=raw,index=0\
			-drive file=fs.img,media=disk,format=raw,index=1\
			-m 512 -smp ${CPUS}
		
# -drive file=dev.img,media=disk,format=raw,index=2\

CPUS = 1
GDBPORT = 2500
BOCHS	= 	bochs -f .bochsrc

TMPDIR = tmp

fs.img:
	bximage -mode=create fs.img -hd=32
	mkfs.fat fs.img

usr:
	${MAKE} -C usr
	if [ -d "${TMPDIR}/" ];then\
		umount ${TMPDIR};\
		rm -rf ${TMPDIR};\
	fi
	mkdir ${TMPDIR}
	mount -t vfat fs.img ${TMPDIR}
	cp usr/_* ${TMPDIR}

all:
	${MAKE} -C include
	${MAKE} -C boot
	${MAKE} -C kernel
	dd if=boot/boots.bin of=${OS_IMG} bs=512 conv=notrunc
	dd if=kernel/kernel.o of=${OS_IMG} bs=512 seek=1 conv=notrunc
	${MAGIC}
	
gdb: CCOPTS += -g
gdb:
	${MAKE} -C include
	${MAKE} -C boot	gdb
	${MAKE} -C kernel gdb
	dd if=boot/boots.bin of=${OS_IMG} bs=512 conv=notrunc
	dd if=kernel/kernel.o of=${OS_IMG} bs=512 seek=1 conv=notrunc
	${MAGIC}

img:
	bximage -mode=create -hd=10 -imgmode=flat -q ${OS_IMG}
# ifneq ($(wildcard ${OS_IMG}),)
# 	rm -f ${OS_IMG}
# endif
# bximage -mode=create -fd=1.44M -imgmode=flat -q ${OS_IMG}

bochs: all
	${BOCHS} 
# -q 'gdbstub: enabled=0'
# bochs-gdb: bochs-img gdb
# 	${BOCHS}

qemu: all
	${QEMU} ${QEMUOPTS}
qemu-gdb: gdb
	${QEMU} -S ${QEMUOPTS} -gdb tcp::$(GDBPORT)
qemu-vnc: all
	${QEMU} ${OS_IMG} -vnc 192.168.88.128:5900

#use this command with bochs-gdb
# --tui 
debug:
	gdb -ex "target extended-remote localhost:${GDBPORT}" -ex "file kernel/kernelsource"
# -ex "file boot/bootsource"

clean:
	${MAKE} -C boot clean
	${MAKE} -C kernel clean
	${MAKE} -C usr clean
	if [ -d "${TMPDIR}/" ];then\
		umount ${TMPDIR};\
		rm -rf ${TMPDIR};\
	fi
	rm -f *.tags *.log fs.img

.PHONY: clean img usr gdb all fs.img
