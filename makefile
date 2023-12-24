# Name of the compiler
CC = gcc

# Compilation options
CFLAGS = -Wall -g -fPIC

# Name of the dynamic library
LIB_NAME = monjeu
LIB = lib$(LIB_NAME).so

# Name of the executable
EXEC = main

# Source files for the library and the executable
LIB_SRCS = initialize.c display.c turn.c update.c
LIB_OBJS = $(LIB_SRCS:.c=.o)

MAIN_SRC = main.c
MAIN_OBJ = $(MAIN_SRC:.c=.o)

# Default rule
all: $(LIB) $(EXEC)

# Rule to create the dynamic library
$(LIB): $(LIB_OBJS)
	$(CC) -shared -o $@ $(LIB_OBJS)

# Rule to create the executable
$(EXEC): $(MAIN_OBJ) $(LIB)
	$(CC) $(CFLAGS) -o $(EXEC) $(MAIN_OBJ) -L. -lmonjeu

# Rule for object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Header file dependencies
$(MAIN_OBJ): $(MAIN_SRC) game.h display.h turn.h update.h
initialize.o: initialize.c initialize.h game.h
display.o: display.c display.h game.h
turn.o: turn.c turn.h game.h
update.o: update.c update.h game.h

# Rule to clean up compiled files
clean:
	rm -f $(LIB_OBJS) $(MAIN_OBJ) $(EXEC) $(LIB)
