
program2: program2.o shiftRight.o
	ld -dynamic-linker /lib/ld-linux.so.2 program2.o shiftRight.o -o program2 -lc
program2.o: program2.s
	as -g program2.s -o program2.o
shiftRight.o: shiftRight.s
	as -g shiftRight.s -o shiftRight.o
