EXE= cruscotto
AS= as --32
LD= ld -m elf_i386
FLAGS= -gstabs
OBJ= obj/main.o obj/move.o

bin/$(EXE): $(OBJ)
	$(LD) -o bin/$(EXE) $(OBJ)
obj/main.o: src/main.s
	$(AS) $(FLAGS) -o obj/main.o src/main.s
obj/move.o: src/move.s
	$(AS) $(FLAGS) -o obj/move.o src/move.s

clean:
	rm -f obj/*.o $(EXE) core
	rm -f bin/cruscotto $(EXE) core
