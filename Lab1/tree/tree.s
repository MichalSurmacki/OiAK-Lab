EXIT = 1
READ = 3
STDIN = 0
WRITE = 4
STDOUT = 1
SYSCALL32 = 0x80

.section .data
	star: .ascii "*"
	space: .ascii " "
	newline: .ascii "\n"
	number: .long
.section .text

.globl _start

_start:

movl $READ, %eax
movl $STDIN, %ebx
movl $number, %ecx
movl $1, %edx

int $SYSCALL32

movl number, %ebx
subl $48, %ebx

movl %ebx, %edi
pushl %edi #wysokosc choinki
pushl %ebp #zawartosc starego ebp
movl %esp, %ebp
pushl %edi #wysokosc choinki jeszcze raz
movl $1, %eax	#licznik
pushl %eax #licznik
movl %edi, %eax
subl $1, %eax
pushl %eax #wysokosc do spacji na koniec

first_loop_start:

movl 4(%ebp), %edi #wysokosc choinki jako indeks
cmpl $0, %edi
je first_loop_end

movl -4(%ebp), %edi
subl $1, %edi
movl %edi, -4(%ebp)

second_loop_start:

cmpl $0, %edi
je second_loop_end

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $space, %ecx
movl $1, %edx
int $SYSCALL32

subl $1, %edi
cmpl $0, %edi
je second_loop_end
jmp second_loop_start

second_loop_end:
movl -8(%ebp), %edi

third_loop_start:

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $star, %ecx
movl $1, %edx
int $SYSCALL32

subl $1, %edi
cmpl $0, %edi
je third_loop_end
jmp third_loop_start

third_loop_end:

movl -8(%ebp), %edi
addl $2, %edi
movl %edi, -8(%ebp)
movl 4(%ebp), %edi
subl $1, %edi
movl %edi, 4(%ebp)

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $1, %edx
int $SYSCALL32

jmp first_loop_start

first_loop_end:

movl -12(%ebp), %edi

space_loop_start:

cmpl $0, %edi
je space_loop_end

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $space, %ecx
movl $1, %edx

int $SYSCALL32

subl $1, %edi
jmp space_loop_start
space_loop_end:

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $star, %ecx
movl $1, %edx
int $SYSCALL32

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $1, %edx
int $SYSCALL32

movl $1, %eax
movl $0, %ebx
int $SYSCALL32
