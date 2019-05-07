########
# Funkcja przyjmujaca 2 argumenty liczba_przesuniecia i mantysa
# Zwraca na stosie: zaokraglona mantyse
#Zaokraglenie: Symetrycznie do Parzystej
#######

.section .data
	dataToShift: .space 32
	shiftCount: .space 32
	retAdres: .space 32
.section .text

.globl shiftRight

shiftRight:

popl retAdres
popl dataToShift
popl shiftCount
pusha #wrzucenie na stos wszystkich rejestrów

movl dataToShift, %eax
movl shiftCount, %ecx

movl $1, %edi
shl %cl, %edi
and %eax, %edi #G w %edi

dec %ecx
movl $1, %ebx
shl %cl, %ebx
and %eax, %ebx #R w %ebx

dec %ecx
movl $1, %edx
shl %cl, %ebx
and %eax, %edx #S w %edx

movl shiftCount, %ecx
shr %cl, %eax

cmpl $0, %ebx
je end
cmpl $0, %edx
je special
jmp end
special:
cmpl $1, %edi
je addOne
jmp end

addOne:
addl $1, %eax

end:

movl %eax, dataToShift
popa #restore rejestrów
pushl shiftCount
pushl dataToShift
pushl retAdres
ret
