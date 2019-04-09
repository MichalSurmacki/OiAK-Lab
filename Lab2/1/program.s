WRITE = 4
STDOUT = 1
SYSCALL32 = 0x80
EXIT = 1
GOODEXITSTATUS = 0
 
.section .data
	newline: .ascii "\n"
.section .text

.globl _start

_start:

pop %edi #pobranie argc

argument_loop_start:
cmpl $0, %edi
je argument_loop_end
dec %edi

pop %ecx #pobranie argv
movl $0, %edx

arg_length_start:
movb (%ecx, %edx, 1), %al #porownuje jeden bajt
cmpb $0, %al
je arg_length_end
inc %edx
jmp arg_length_start
arg_length_end:

movl $WRITE, %eax
movl $STDOUT, %ebx
int $SYSCALL32

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $1, %edx
int $SYSCALL32
jmp argument_loop_start
argument_loop_end:

#TERAZ WYSWIETLE ZAWARTOSC SRODOWISKOWA

pop %ecx 
start_zawartosc:
pop %ecx

cmpl $0, %ecx
je exit


movl $0, %edx

aarg_length_start:
movb (%ecx, %edx, 1), %al #porownuje jeden bajt
cmp $0, %al
je aarg_length_end
inc %edx
jmp aarg_length_start
aarg_length_end:

movl $WRITE, %eax
movl $STDOUT, %ebx
int $SYSCALL32

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $newline, %ecx
movl $1, %edx
int $SYSCALL32

jmp start_zawartosc

exit:
movl $EXIT, %eax
movl $GOODEXITSTATUS, %ebx
int $SYSCALL32
