.section .data

	input: .space 128
	inputSize: .long
	retAddres: .long
.section .text

.globl stox

stox:

movl $0, %eax

pop retAddres	#zdjęcie ze stosu adresu powrotu z funkcji

pop %ecx	#pierwszy na stosie element

pop %edx	#drugi na stosie rozmiar tego elementu

dec %edx

skoktu:

movl $0, %esi
movl $1, %edi

start_8:

movl $8, %ebx
cmpl $-1, %edx
je end_8

#start parsowania#########################
calc_start:
movl %edi, %ebp
movb (%ecx, %edx, 1), %al
dec %edx

cmpb $65, %al
jge letter

sub $48, %al	#jesli znak ascii < 65 najprawdopodobniej jest to cyfra dlatego odejmuje 48
jmp digit
		#jge - oznacza 1 większe bądź równe 2
letter:
cmpb $97, %al
jge big_letter
sub $55, %al	#jest to mała litera dlatego odejmuje 55

jmp digit

big_letter:
sub $87, %al	#jest to wielka litera dlatego odejmuje 87

digit:
imull %eax, %ebp
addl %ebp, %esi
imull $16, %edi

dec %ebx

cmpl $-1, %edx
je pushElement

cmpl $0, %ebx   #kiedy 0 w ebx parsujemy nastepne 8
je pushElement
#dec %ebx        #kolejny obieg dekrementujemy

jmp calc_start

pushElement:
pop %edi
cmpl $0, %edi
je one
two:
pushl %esi
inc %edi
pushl %edi

jmp skoktu

end_8:

pushl retAddres 

ret

one:
pushl %edi
jmp two
