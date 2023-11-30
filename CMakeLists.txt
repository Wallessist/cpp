cmake_minimum_required(VERSION 3.15...3.20)

project(MyProject VERSION 1.0 LANGUAGES CXX)

# Set build type with a default value: Debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "" FORCE)
endif()


# c++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# compilation option.
add_compile_options(-Wall -Wextra -Wpedantic)


# Source files.
aux_source_directory(src SOURCE_LIST)

# Generating lib.
set(LIB_NAME ${PROJECT_NAME}_library)

add_library(${LIB_NAME} ${SOURCE_LIST})

target_include_directories(${LIB_NAME} PUBLIC include)

# Generating program.
set(THE_TARGET ${CMAKE_BUILD_TYPE})

add_executable(${THE_TARGET} apps/main.cpp)

target_link_libraries(${THE_TARGET} PRIVATE ${LIB_NAME})

