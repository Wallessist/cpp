###############################################################################
#                             Directory structure.                            #
###############################################################################

# Store source files.
DIR_SRC = src

# Store head files.
DIR_INC = include

# Store test files.
DIR_TEST = test

# Store example files.
DIR_EXAMPLE = example

# Place to store building files.
DIR_BUILD = build

# Debug.
DIR_DEBUG = $(DIR_BUILD)/debug

# Release.
DIR_RELEASE = $(DIR_BUILD)/release

# Object files' directory.
DIR_OBJ = obj


###############################################################################
#                                Source files                                 #
###############################################################################

INCS := $(wildcard $(DIR_INC)/*.h)
SRCS := $(wildcard $(DIR_SRC)/*.cpp)
OBJS :=

# Target file.
TARGET = debug


###############################################################################
#                                Compile flags.                               #
###############################################################################

# Setting flags.
CXX := $(shell which g++)
CXXFLAGS += -std=c++17
CPPFLAGS += -MMD -MP


###############################################################################
#                                   Options.                                  #
###############################################################################

# Build mode as one of [debug=default, release], controls which build.
RELEASE ?= off

ifeq ($(RELEASE), off)
	CXXFLAGS += -g
	DIR_OBJ := $(DIR_DEBUG)/$(DIR_OBJ)
	TARGET := $(DIR_DEBUG)/debug
else
	CXXFLAGS += -O3
	DIR_OBJ := $(DIR_RELEASE)/$(DIR_OBJ)
	TARGET := $(DIR_RELEASE)/release
endif
OBJS := $(SRCS:$(DIR_SRC)%.cpp=$(DIR_OBJ)%.o)

###############################################################################
#                           Project building rules.                           #
###############################################################################

# Makefile enterpoint.
all: directory $(TARGET)

# Generating final target.
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $< -o $@

# Spawn the corresponding .o and .d files for every .cpp file.
$(DIR_OBJ)/%.o: $(DIR_SRC)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

# Generating build directories.
directory:
	mkdir -p $(DIR_OBJ)

-include ${OBJS:.o=.d}


###############################################################################
#                                Build commands.                              #
###############################################################################

.PHONY: debug release clean

debug:
	@$(MAKE)

release:
	@$(MAKE) RELEASE=on

clean:
	rm -rf build


###############################################################################
#                                User commands.                               #
###############################################################################

# Build and run.
run:
	$(MAKE) debug
	./$(TARGET)

gdb:
	$(MAKE) debug
	gdb $(TARGET)

# Generating {.clang-format} file.
Gen-clangFormat:
	clang-format -style=google -dump-config > .clang-format

# Generating {compile-command.json} file.
bear:
	bear -- $(MAKE) -j$(nproc) debug

project:
	mkdir -p $(DIR_SRC) $(DIR_INC)
	$(MAKE) Gen-clangFormat


