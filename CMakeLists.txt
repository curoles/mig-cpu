cmake_minimum_required (VERSION 3.22)

# @copyright Igor Lesik 2020-2023
# @authors   Igor Lesik 2020-2023
# @brief     CMake top level script to build MIGCPU project.

project(MIGCPU
    VERSION 0.1.0
    DESCRIPTION "MIG CPU Core"
    LANGUAGES CXX C #ASM
)

# CMakeLists files in this project can refer
# to the root source directory of the project as ${MIGCPU_SOURCE_DIR} and
# to the root binary directory of the project as ${MIGCPU_BINARY_DIR}.

# Requires C++20.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Verilator is default Verilog compiler,
# to turn it off: `cmake -D USE_VERILATOR=OFF ../mig-cpu`
option(USE_VERILATOR "Use Verilator to compile Verilog" ON)

# Compiler options.
set(C_WARN_FLAGS "-Werror -Wall")
set(C_OPT_FLAGS "-O3 -march=native -ftree-vectorize")
set(CMAKE_CXX_FLAGS "${C_WARN_FLAGS} ${C_OPT_FLAGS}")
#set(CMAKE_EXE_LINKER_FLAGS "-Wl,-z,stack-size=1000000")

# Install inside the build directory.
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)

include_directories(.)

enable_testing()

add_subdirectory(test)

# Log CMake variables.
MESSAGE( STATUS "CMAKE_C_COMPILER    : " ${CMAKE_C_COMPILER} )
MESSAGE( STATUS "CMAKE_CXX_COMPILER  : " ${CMAKE_CXX_COMPILER} )
MESSAGE( STATUS "CMAKE_CXX_FLAGS     : " ${CMAKE_CXX_FLAGS} )
MESSAGE( STATUS "CMAKE_INSTALL_PREFIX: " ${CMAKE_INSTALL_PREFIX} )
MESSAGE( STATUS "USE VERILATOR       : " ${USE_VERILATOR} )
