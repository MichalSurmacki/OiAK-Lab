.section .data

	input1: .int 0
	input2: .int 0
	inputFormat: .string "%f"
	outputFormat: .string "%f\n"
	outputIntSin: .string "calka z sin(X): "
	outputIntLog: .string "calka z log(x): "

.section .text

.globl _start

_start:

pushl $input1
pushl $inputFormat
call scanf

pushl $input2
pushl $inputFormat
call scanf

fld input2 #kopiowanie do st0 z jednoczesna zamiana na dubble
fcos #obliczenie cos z tego co w st0

fld input1 #kopiowanie do st0 z jednoczesna zamiana na dubble, last st0 w st1 
fcos #obliczenie cos z tego co w st0

fsubp #odjecie od st0, st1 wynik w st1 p-pop st0, czyli wynik w st0

pushl $outputIntSin
call printf

subl $8, %esp #robie miejsce dla dubble - 64 bity
fstl (%esp) #wlozenie na stos st0

pushl $outputFormat
call printf

fldl2t #wrzucenie log_2(10)
fld1 #wrzucenie jedynki
fld input2
fyl2x
fdivp #w tym momencie w st(0) log_10(input1)
fld1
fsub %st, %st(1)

fsubp

#pushl $outputIntLog
#call printf

#subl $8, %esp
#fstl (%esp)

pushl $outputFormat
call printf


pushl $0
call exit


