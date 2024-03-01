.code16
msg:
	.string "Hello World \n\r"
.globl main
main:
	cli

	movw    $0x7c0,%ax          
	movw    %ax,%ds          
	movw    %ax,%es          

 	movw 	msg,%si

print:	
	lodsb
	movb $0xe,%ah
	cmpb $0,%al
	je fin
	movw $15,%bx
	movw $1,%cx
	int $0x10
	jmp print
fin:
	hlt
	jmp fin

