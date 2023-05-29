EXE= eseguibile
AS= as --32
LD= ld -m elf_i386
FLAGS= -gstabs
OBJ= main.o move.o

$(EXE): $(OBJ)
	$(LD) -o $(EXE) $(OBJ)
main.o: main.s
	$(AS) $(FLAGS) -o main.o main.s
move.o: move.s
	$(AS) $(FLAGS) -o move.o move.s
clean:
	rm -f *.o $(EXE) core