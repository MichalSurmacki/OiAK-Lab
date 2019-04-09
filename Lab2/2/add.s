.section .data

	part1: .space 32
	part2: .space 32
	part3: .space 32
	part4: .space 32
	format: .string "%08x%08x%08x%08x\n"
.section .text

.globl add

add:

#pop retAddres
#pop rozm2
push %ebp
movl %esp, %ebp

movl $8, %eax
movl (%ebp,%eax,1), %ebx
movl %ebx, %eax #eax przechowuje rozmiar 2
		#ebx przechowuje rozmiar 2
movl $4, %ecx
imull %ebx, %ecx
addl $16, %ecx

movl (%ebp, %ecx, 1), %ecx #ecx przechowuje rozmiar 1

imull $4, %eax
addl $8, %eax
movl (%ebp, %eax, 1), %edx #eax przechowuje indeks do ostatniej czesci 2

movl %eax, %ebx
addl $8, %ebx	#ebx przechowuje indeks do rozmiaru 1

imull $4, %ecx
addl %eax, %ecx
addl $8, %ecx #ecx przechowuje indeks do ostatniej czesci 1
movl (%ebp, %ecx, 1), %edi

addl %edi, %edx
movl %edx, part1
pushf
#################

subl $4, %eax
cmpl $8, %eax
jle zero
movl (%ebp, %eax, 1), %edx
jmp licz
zero:
movl $0, %edx
licz:

subl $4, %ecx
cmpl %ebx, %ecx
jle zero2
movl (%ebp, %ecx, 1), %edi
jmp licz2
zero2:
movl $0, %edi
licz2:

popf
adcl %edi, %edx
movl %edx, part2
pushf
############

subl $4, %eax
cmpl $8, %eax
jle zero3
movl (%ebp, %eax, 1), %edx
jmp licz3
zero3:
movl $0, %edx
licz3:

subl $4, %ecx
cmpl %ebx, %ecx
jle zero4
movl (%ebp, %ecx, 1), %edi
jmp licz4
zero4:
movl $0, %edi
licz4:

popf
adcl %edi, %edx
movl %edx, part3
pushf
############

subl $4, %eax
cmpl $8, %eax
jle zero5
movl (%ebp, %eax, 1), %edx
jmp licz5
zero5:
movl $0, %edx
licz5:

subl $4, %ecx
cmpl %ebx, %ecx
jle zero6
movl (%ebp, %ecx, 1), %edi
jmp licz6
zero6:
movl $0, %edi
licz6:

popf
adcl %edi, %edx
movl %edx, part4

############

pushl part1
pushl part2
pushl part3
pushl part4
pushl $format
call printf

pop %ebp
pop %ebp
pop %ebp
pop %ebp
pop %ebp
pop %ebp

ret
