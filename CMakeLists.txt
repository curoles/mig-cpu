cmake_minimum_required (VERSION 3.22)

# @copyright Igor Lesik 2020-2023
# @authors   Igor Lesik 2020-2023
# @brief     cmake script to build MIGCPU project.

project(MIGCPU)
# CMakeLists files in this project can refer
# to the root source directory of the project as ${MIGCPU_SOURCE_DIR} and
# to the root binary directory of the project as ${MIGCPU_BINARY_DIR}.

# Requires C++20.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
