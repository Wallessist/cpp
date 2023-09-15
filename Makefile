# Makefile for lightweight cpp project.

#	Project directory structrure.
SRC_DIR = .
INC_DIR = .

# Directory(s) should be generate by make.
OBJ_DIR = .obj
$(shell mkdir -p $(OBJ_DIR))

INCS := $(wildcard $(INC_DIR)/*.h)
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(SRCS:$(SRC_DIR)%.cpp=$(OBJ_DIR)%.o)

MAIN := main

DEBUGSYM = -g
LIBS := -lncurses
CXXFLAGS += $(DEBUGSYM)
# Debug setting.
#ifeq ($(DEBUG), 1)
#		CXXFLAGS += $(DEBUGSYM)
#endif


all: $(MAIN)

run: $(MAIN)
	./$(MAIN)

$(MAIN) : $(OBJS)
	$(CXX) $(CXXFLAGS) $(LIBS) $^ -o $@

# Spawn the corresponding .o and .d files for every .cpp file.
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MMD -MP -c $< -o $@


.PHONY: cleanobj clean gdb bear debug parallelism

bear:
	bear -- make -j$(nproc)

cleanobj:
	rm -rf $(OBJ_DIR)

clean: cleanobj
	rm $(MAIN)

gdb:
	gdb $(MAIN)

parallelism:
	make -j$(nproc)

-include ${OBJS:.o=.d}
