
# main.s
# dark_neo
# 2014-09-30

# Compile, link and run:
#	as -o main.o main.s
#	ld -dynamic-linker /libexec/ld-elf.so.1 \
#			-o main /usr/lib/crt1.o /usr/lib/crti.o \
#			/usr/lib/crtbegin.o \
#			-L/usr/lib main.o -lc /usr/lib/crtend.o /usr/lib/crtn.o
#	./main

# Print string on stdout calling UNIX system functions.

	.code64

	.section .data
.LC1:
	.string	"%s\n"

msg:
	.ascii	"Hello world!"
	.byte	0x10
	.byte	0x0A

# Code section
	.text
	.globl main

main:
	push	%rbx
	movl	$msg,		%ebx
	movl	%ebx,		%esi
	leaq	.LC1,		%rdi
	movl	$0x00,		%eax
	call	printf

	xor		%eax,		%eax
	pop		%rbx
	ret

