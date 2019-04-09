.section .data
	input: .space 64
	inputFormat: .string "%s"
	outputFormat: .string "%d"
	msg1: .string "Podaj liczbe w formacie HEX:"
	msg2: .string "Twoja liczba HEX tylko ze w DEC:"
	newline: .string "\n"
.section .text

.globl _start

_start:

pushl $msg1
pushl $inputFormat
call printf

pushl $input
pushl $inputFormat
call scanf

#liczenie dlugosci wprowadzonej liczby
movl $input, %ecx
movl $0, %edx
start_go:
movb (%ecx, %edx,1), %al
cmpb $0, %al
je go_end
inc %edx
jmp start_go
go_end:

dec %edx
movl $0, %esi
movl $1, %edi

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

cmpl $-1, %edx
je end_end

jmp calc_start

end_end:

pushl $msg2
pushl $inputFormat
call printf

pushl %esi
pushl $outputFormat
call printf

pushl $newline
call printf

pushl $0
call exit
