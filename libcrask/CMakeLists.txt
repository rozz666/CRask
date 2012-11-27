project(libcrask)

cmake_minimum_required(VERSION 2.8)

include_directories("include" "gmock-1.6.0/fused-src")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -Wall")

add_library(gmock gmock-1.6.0/fused-src/gmock-gtest-all.cc)
add_library(crask src/crask.cpp)
add_executable(crask_ut test/main.cpp test/classes.cpp)
add_executable(crask_demo test/demo.c)
target_link_libraries(crask_ut crask gmock pthread)
target_link_libraries(crask_demo crask)