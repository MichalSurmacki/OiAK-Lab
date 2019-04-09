
tree: tree.o
	ld -melf_i386 tree.o -o tree
tree.o: tree.s
	as --32 -g tree.s -o tree.o
