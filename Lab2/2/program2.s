.section .data

	strFormat: .string "%s"
	input1: .space 128
	input2: .space 128	

.section .text

.extern stox
.extern add

.globl _start

_start:

#Popbranie 2 inputów od użytkownika
pushl $input1
pushl $strFormat
call scanf
pop %eax
pop %eax
pushl $input2
pushl $strFormat
call scanf
pop %eax
pop %eax
#liczenie dlugosci wprowadzonego inputu1
movl $input1, %ecx
movl $0, %edx
start_count1:
movb (%ecx, %edx,1), %al
cmpb $0, %al
je end_count1
inc %edx
jmp start_count1
end_count1:
#włożenie na stos oddzielającego zera przed pierwszym wywołaniem
pushl $0
#włożenie na stos długosci inputu1 oraz input1
pushl %edx
pushl $input1
#wywołanie funkcji wrzucajacej na stos zformatowana liczbe
call stox
pushl $0 #kolejne oddzielające zero



#liczenie dlugosci wprowadzonego inputu2
movl $input2, %ecx
movl $0, %edx
start_count2:
movb (%ecx, %edx,1), %al
cmpb $0, %al
je end_count2
inc %edx
jmp start_count2
end_count2:
#włożenie na stos długości inputu2 oraz input2
pushl %edx
pushl $input2

#wywolanie funkcji wrzucajacej na stos zformatowana liczbe
call stox

call add

movl 4(%esp), %edx


push $0
call exit
