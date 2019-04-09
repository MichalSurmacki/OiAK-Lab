
program2: program2.o stox.o add.o
	ld -dynamic-linker /lib/ld-linux.so.2 program2.o stox.o add.o -o program2 -lc
program2.o: program2.s
	as -g program2.s -o program2.o
stox.o: stox.s
	as -g stox.s -o stox.o
add.o: add.s
	as -g add.s -o add.o
