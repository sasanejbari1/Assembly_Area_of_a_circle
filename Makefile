

# Compile and Link Variable
CC := gcc
CC_FLAGS := -Wall -m64 -gdwarf-2 -c
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2
LINKER := gcc
LINKER_FLAGS := -Wall -m64 -gdwarf-2 -no-pie 


# Executable name
BIN_NAME := my-program
BIN := ./$(BIN_NAME)

run:	build
	@echo "Running program!"
	./my-program

build: $(BIN)
.PHONY: build

#
$(BIN): area.o main.o
	$(LINKER) $(LINKER_FLAGS) *.o *.so -o my-program
	@echo "Done"


area.o: area.asm
	$(ASM) $(ASM_FLAGS) area.asm -o area.o


main.o: main.c
	$(CC) $(CC_FLAGS) main.c -o main.o


# ca make targets as many as want

clean: 
	-rm *.o
	-rm $(BIN)














