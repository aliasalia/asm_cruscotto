EXE= eseguibile
AS= as --32
LD= ld -m elf_i386
FLAGS= -gstabs
OBJ= obj/main.o obj/move.o obj/set_blinkers.o obj/index_position_message.o obj/navigate_menu.o

bin/$(EXE): $(OBJ)
	$(LD) -o bin/$(EXE) $(OBJ)
obj/main.o: src/main.s
	$(AS) $(FLAGS) -o obj/main.o src/main.s
obj/move.o: src/move.s
	$(AS) $(FLAGS) -o obj/move.o src/move.s
obj/set_blinkers.o: src/set_blinkers.s
	$(AS) $(FLAGS) -o obj/set_blinkers.o src/set_blinkers.s
obj/index_position_message.o: src/index_position_message.s
	$(AS) $(FLAGS) -o obj/index_position_message.o src/index_position_message.s
obj/navigate_menu.o: src/navigate_menu.s
	$(AS) $(FLAGS) -o obj/navigate_menu.o src/navigate_menu.s

clean:
	rm -f obj/*.o $(EXE) core
	rm -f bin/eseguibile $(EXE) core
