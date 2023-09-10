# The very simple build which just compiles all the source files in current
# directory every time.

heads := $(wildcard *.h)
sources := $(wildcard *.cpp)
objects := $(patsubst %.cpp,%.o,$(sources))
libs := -lncurses
MAIN := main

$(MAIN) : $(objects)
	g++ $(libs) -o $(MAIN) $(objects)

$(objects) : $(heads)

run : $(MAIN)
	./$(MAIN)

.PHONY : cleanobj cleanall gdb bear

bear :
	bear -- make

cleanobj :
	rm $(objects)

cleanall : cleanobj
	rm $(MAIN)

gdb :
	gdb $(MAIN)
