
program4: program4.o
	ld -dynamic-linker /lib/ld-linux.so.2 -o program4 program4.o -lc
program4.o: program4.s
	as -g program4.s -o program4.o
