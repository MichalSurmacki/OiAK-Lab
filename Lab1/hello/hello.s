EXIT = 1
WRITE = 4
STDOUT = 1
SYSCALL32 = 0x80

.section .data
	msg: .ascii "Hello World\n"
	msg_len = . - msg
.section .text

.globl _start

_start:
 
movl $WRITE, %eax
movl $STDOUT, %ebx
movl $msg, %ecx
movl $msg_len, %edx

int $SYSCALL32

movl $EXIT, %eax
movl $0, %ebx

int $SYSCALL32
