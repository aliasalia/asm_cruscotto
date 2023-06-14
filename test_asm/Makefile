EXE= eseguibile
AS= as --32
LD= ld -m elf_i386
FLAGS= -gstabs
OBJ= main.o move.o set_blinkers.o index_position_message.o navigate_menu.o

$(EXE): $(OBJ)
	$(LD) -o $(EXE) $(OBJ)
main.o: main.s
	$(AS) $(FLAGS) -o main.o main.s
move.o: move.s
	$(AS) $(FLAGS) -o move.o move.s
set_blinkers.o: set_blinkers.s
	$(AS) $(FLAGS) -o set_blinkers.o set_blinkers.s
index_position_message.o: index_position_message.s
	$(AS) $(FLAGS) -o index_position_message.o index_position_message.s
navigate_menu.o: navigate_menu.s
	$(AS) $(FLAGS) -o navigate_menu.o navigate_menu.s

clean:
	rm -f *.o $(EXE) core
