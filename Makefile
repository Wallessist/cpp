# Handy command for construct build and project setting.

.PHONY: build debug run clean

all: build

# Build type, with the same optional values as cmake.
BUILD_TYPE ?= Debug

BUILD_DIR := build/${BUILD_TYPE}
BUILD_TARGET := ${BUILD_TYPE}

CMAKE_ARGS := -S. -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=${BUILD_TYPE}

# Default build( Debug ), also can used to generate other build type by setting
# Makefile option. See the "debug:" target as an example.
build:
	cmake ${CMAKE_ARGS} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	cmake --build ${BUILD_DIR}

debug:
	make BUILD_TYPE=Debug build

release:
	make BUILD_TYPE=Release build

# Execute Debug program.
run:
	@make debug
	@${BUILD_DIR}/${BUILD_TARGET}

# Generate {compile_commands.json} file.
compile-commands:
	cmake ${CMAKE_ARGS} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	if [ ! -e ./compile_commands.json ];then \
	ln ${BUILD_DIR}/compile_commands.json .; fi

# Generate {.clang-format} file.
format-file:
	clang-format -style=google -dump-config > .clang-format

clean:
	rm -rf build

clean-clangd:
	rm -rf .cache

clean-all: clean clean-clangd
	rm ./compile_commands.json
