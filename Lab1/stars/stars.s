SYSCALL32 = 0x80
EXIT = 1
STDIN = 0
READ = 3
STDOUT = 1
WRITE = 4

.section .data
	newline: .ascii "\n"
	star: .ascii "*"
	number: .long 0

.section .text

.globl _start

_start:

movl $READ, %eax
movl $STDIN, %ebx
movl $number, %ecx
movl $1, %edx

int $SYSCALL32

subl $48, number

movl number, %edi

loop_start:

cmpl $0, %edi
je loop_end

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $star, %ecx
movl $1, %edx

int $SYSCALL32

subl $1, %edi

jmp loop_start

loop_end:

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $1, %edx

int $SYSCALL32

movl $EXIT, %eax
movl $0, %ebx

int $SYSCALL32
