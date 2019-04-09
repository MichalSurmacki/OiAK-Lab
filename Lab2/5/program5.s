WRITE = 4
STDOUT = 1
READ = 3
STDIN = 0
EXIT = 1
GOODEXITSTATUS = 0
SYSCALL32 = 0x80

.section .data
	newline: .string "\n"
	msg0: .string "Wczytano jako parametry wywolania:"
	msg1: .string "Wszytuje za pomoca SYSCALL:"
	msg1_len = . - msg1
	msg2: .string "Wczytuje za pomoca SCANF:"
	value1: .space 4
	value2: .space 4
	format: .string "%4s"
	format2: .string "Input: %s!\n"
.section .text

.globl _start

_start:

pushl $msg0
call printf

pop %edx	#zdjecie msg0
pop %edx	#zdjęcie argc
pop %edx	#zdjęcie ścieżki

start_argv:
pop %edx	#zdjecie parametru wywolania
cmpl $0, %edx
je end_argv
pushl %edx
call printf
pop %edx
push $newline
call printf
pop %edx
jmp start_argv
end_argv:

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $msg1, %ecx
movl $msg1_len, %edx
int $SYSCALL32

movl $READ, %eax
movl $STDIN, %ebx
movl $value1, %ecx
movl $3, %edx
int $SYSCALL32

pushl $msg2
call printf

pushl $value2
pushl $format
call scanf

pushl $value1
pushl $format2
call printf
pushl $value2
pushl $format2
call printf


pushl $0
call exit
