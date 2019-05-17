
program1: program1.o
	ld -dynamic-linker /lib/ld-linux.so.2 program1.o -o program1 -lc
program1.o: program1.s
	as -g program1.s -o program1.o
