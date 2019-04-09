
program5: program5.o
	ld -dynamic-linker /lib/ld-linux.so.2 -o program5 program5.o -lc
program5.o: program5.s
	as -g program5.s -o program5.o
