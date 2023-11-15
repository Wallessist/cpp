# Note:
# [foo = value] means foo will has different values under different options and
# 	should use with caution.
# [bar := value] means bar is constant and is not affect by different options.
# [cei ?= value] defines cei as an option with default value and its value can
# 	be changed with command: make cei=othervalue.


###############################################################################
#                             Directory structure.                            #
###############################################################################

# Suffix meaning.
# _STR : normal string object, used to construct object of other type.
# _DIR : directory object.

DEBUG_STR := debug
RELEASE_STR := release
OBJ_STR := obj

TARGET_STR = $(DEBUG_STR)

# Source directory.
SRC_DIR := src
# Include directory.
INC_DIR := include
# Test direcotry.
TEST_DIR := test
# Example directory.
EXAMPLE_DIR := example
# Build directory.
BUILD_DIR := build
# Debug directory.
DEBUG_DIR := $(BUILD_DIR)/$(DEBUG_STR)
# Release directory.
RELEASE_DIR := $(BUILD_DIR)/$(RELEASE_STR)

# Target directory.
TARGET_DIR = $(BUILD_DIR)/$(TARGET_STR)
# Object files' directory.
OBJ_DIR = $(TARGET_DIR)/$(OBJ_STR)

###############################################################################
#                                Source files                                 #
###############################################################################

INCS := $(wildcard $(INC_DIR)/*.h)
SRCS := $(wildcard $(SRC_DIR)/*.cpp)

OBJS = $(SRCS:$(SRC_DIR)%.cpp=$(OBJ_DIR)%.o)
TARGET = $(TARGET_DIR)/$(TARGET_STR)


###############################################################################
#                                Compile flags.                               #
###############################################################################

# Setting flags.
CXX := $(shell which g++)
WARNING :=
CXXFLAGS += -std=c++17
CPPFLAGS += -MMD -MP


###############################################################################
#                                   Options.                                  #
###############################################################################

# Construct debug or release build.
RELEASE ?= off

ifeq ($(RELEASE), on)
	CXXFLAGS += -O3
	TARGET_STR = $(RELEASE_STR)
else
	CXXFLAGS += -g
endif

###############################################################################
#                           Project building rules.                           #
###############################################################################

# Makefile enterpoint.
all: directory $(TARGET)

# Generating final target.
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

# Spawn the corresponding .o and .d files for every .cpp file.
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

# Generating build directories.
directory:
	mkdir -p $(OBJ_DIR)

-include ${OBJS:.o=.d}


###############################################################################
#                                Build commands.                              #
###############################################################################

.PHONY: debug release build clean

debug:
	@$(MAKE)

release:
	@$(MAKE) RELEASE=on

build:
	@$(MAKE)
	@$(MAKE) release

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
	mkdir -p $(SRC_DIR) $(INC_DIR)
	$(MAKE) Gen-clangFormat
