.section .text
.globl my_sin

.type my_sin, @function

my_sin:

fld 4(%esp)
fsin

ret
