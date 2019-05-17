numberN = 10000
.section .data
	input1: .space 64
	input2: .space 64
	xOne: .space 64
	output: .string "wartosc calki oznaczonej: %f\n"
	inputFormat: .string "%f"
	trapHeight: .space 64
	resultSin: .space 64
.section .text

.globl _start

_start:

pushl $input1
pushl $inputFormat
call scanf

pushl $input2
pushl $inputFormat
call scanf

pushl $numberN
fld1
fimul (%esp)
popl %eax

fld input2
fld input1
fsubp %st, %st(1) #st0 wartosc input1-input2
# dodane p w fsubp poniewaz wynik przechowywany w st1, po pop bedzie w st0
fdivp %st, %st(1)
fstp trapHeight #obliczenie wysokosci trapezu

movl $numberN, %edx #edx naszym indeksem

fld input1
fst xOne
fld trapHeight
fld input1
fsubp %st, %st(1) #w st0 x_dolne w st1 x_gorne

start_loop:

#INSTRUKCJE DLA CAŁKI Z LOG(X)
#fldl2t
#fld1
#fxch %st(1)
#fxch %st(2)

#fyl2x
#fdivp %st, %st(1)
#fxch %st(1)

#fldl2t
#fld1
#fxch %st(1)
#fxch %st(2)

#fyl2x
#fdivp %st, %st(1)
#/INSTRUKCJE DLA CAŁKI Z LOG(X)

#INSTRUKCJE DLA CAŁKI Z SIN(X)
fsin
fxch %st(1)
fsin
#/INSTRUKCJE DLA CAŁKI Z SIN(X)

faddp
fld1
pushl $2
fimul (%esp)
popl %eax
fxch %st(1)
fdivp %st, %st(1)
fld trapHeight
fmulp
fld resultSin
faddp
fstp resultSin

fld xOne
fld trapHeight
fld xOne
fsubp %st, %st(1)
fst xOne

dec %edx
cmpl $-1, %edx
je end_loop
jmp start_loop

end_loop:

fld resultSin
subl $8, %esp
fstl (%esp)

pushl $output
call printf

pushl $0
call exit
