
# main.s
# dark_neo
# 2014-09-30

# Compile, link and run:
#	as main.s -o main.o
#	ld -o main main.o
#	./main

# Print string on stdout calling UNIX system functions.

	.code64

# Constants
	.equiv	STDOUT,		0x01		# File descriptor for stdout.
	.equiv	RETVAL, 	0x00		# argument for exit().
	.equiv	SYS_WRITE,	0x04		# write() syscall ID.
	.equiv	SYS_EXIT,	0x01		# exit() syscall ID.

	.section .data
msg:
	.ascii	"Hello world!"
	.byte 0x0A
	len	= . - msg

# Code section
	.text
	.globl _start

_start:
	# Call system function write:
	# ssize_t write(int fd, const void *buf, size_t nbytes);
	movl	$len,			%edx
	movq	$msg,			%rsi
	movl	$STDOUT,		%edi

	movq	$SYS_WRITE,		%rax
	#movq	%rcx,			%r10		# syscall destroys %rcx. Backup it on
										# %r10.
	syscall

	# Call exit(0);
	movl	$RETVAL,		%edi
	movq	$SYS_EXIT,		%rax
	#movq	%rcx,			%r10		# syscall destroys %rcx.
	syscall

