.section .data
	inputFormat: .string "%f"
	outputFormat: .string "%d\n"
	input1: .space 32
	input2: .space 32
	
.section .text

.extern shiftRight


.globl _start

_start:

pushl $input1
pushl $inputFormat
call scanf

pushl $input2
pushl $inputFormat
call scanf

#sprawdzanie bitów znaku liczb
#and $0x80000000, %eax

#wydzielenie wykladnika 1 liczby
movl input1, %eax
and $0x7F800000, %eax
shr $23, %eax

#wydzielenie wykladnika 2 liczby
movl input2, %ebx
and $0x7F800000, %ebx
shr $23, %ebx

cmpl %eax, %ebx
jg second_greater
#tutaj a>b - info o tym w d=0, instrukcje tez dla a=b
movl $0, %edx
pushl %eax #wrzucenie na stos wiekszego wykł.
sub %ebx, %eax
pushl %eax #wrzucenie na stos poprawki wykł.
movl 4(%esp), %eax
jmp exp_end

second_greater:
movl $1, %edx
#tutaj b>a - info o tym w d=1
pushl %ebx #wrzucenie na stos wiekszego wykł.
sub %eax, %ebx
pushl %ebx #wrzuecnie na stos poprawki wykł.
movl 4(%esp), %eax
exp_end:

cmpl $0, %eax #sprawdzenie czy a jest zdenormalizowane
je a_denor
movl $0x00800000, %edi
jmp a_denor_end
a_denor:
popl %edi #kiedy liczba jest zdenorm. wykł. 0..0 to wykł jest 0..1
dec %edi #zmniejszenie-korekcja, bo wykl. 0..1
pushl %edi
movl $0, %edi
a_denor_end:
movl input1, %eax #wydzielenie mantysy inputu1
and $0x007fffff, %eax 
add %edi, %eax #dodanie 0/1 na wlasciwej poz. przed przec.

cmpl $0, %ebx #sprawdzenie czy b jest zdenormalizowane
je b_denor
movl $0x00800000, %edi
jmp b_denor_end
b_denor:
popl %edi #kiedy liczba jest zdenorm. wykł. 0..0 to wykł jest 0..1
dec %edi #zmniejszenie-korekcja, bo wykl. 0..1
pushl %edi
movl $0, %edi
b_denor_end:
movl input2, %ebx #wydzielenie mantysy inputu2
and $0x007fffff, %ebx
add %edi, %ebx #dodanie 0/1 na wlasciwej poz. przed przec.

#przesuniecie bitowe i zaokraglenie odpowiedniej mantysy
cmpl $0, %edx #korzystanie z pomoc. warto. d
je a_grater
pushl %eax #wrzucenie na stos odpowiedniej mantysy
call shiftRight
popl %eax
jmp end_a_greater

a_grater:
pushl %ebx #wrzucenie na stos odpowiedniej mantysy
call shiftRight
popl %ebx
end_a_greater:

add %eax, %ebx #w ebx wynik dodawania mantys

#liczenie o ile przesunac przecinek
movl $0x400000, %eax
movl $0, %edi
movl $0, %edx
start:
cmpl $9, %edx
je koniec
shl $1, %eax
movl %ebx, %ecx
and %eax, %ecx
inc %edx
cmpl $0, %ecx
je start
movl %edx, %edi
jmp start
koniec:
dec %edi

pushl %edi #w edi liczba przesuniecia przecinka
pushl %ebx #w ebx mantysa do przesuniecia
call shiftRight
popl %ebx

movl (%esp), %ecx #przeniesienie korekty wykladnika
movl 8(%esp), %eax #przeniesienie wykladnika
add %ecx, %eax #dodanie korekty wykladnika
shl $23, %eax #wykładnik na swoim miejscu

and $0x007fffff, %ebx #pozbycie sie 1 przed przec.

or %eax, %ebx #wynik dzialania w ebx

pushl %ebx
pushl $outputFormat
call printf

push $0
call exit
