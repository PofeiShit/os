.global start
.code16
start:
	jmp entry
entry:
	mov $0, %ax
	mov %ax, %ss
	mov %ax, %es
	mov %ax, %ds
	mov $0x7c00, %sp	
	mov $msg, %si
	call putloop
	jmp fin
putloop:
	movb (%si), %al
	add $1, %si
	cmp $0, %al
	je over
	movb $0x0e, %ah
	movw $15, %bx
	int $0x10
	jmp putloop
	
over:
	ret

fin:
	hlt
	jmp	fin

msg:
	.asciz "hello os"

.org 510
.word 0xaa55
