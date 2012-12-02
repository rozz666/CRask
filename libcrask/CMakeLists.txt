project(libcrask)

cmake_minimum_required(VERSION 2.8)

include_directories("include" "gmock-1.6.0/fused-src")

if(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -Wall")
else(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++ -Wall -DGTEST_USE_OWN_TR1_TUPLE=1")
endif(CMAKE_COMPILER_IS_GNUCXX)

add_library(gmock gmock-1.6.0/fused-src/gmock-gtest-all.cc)
add_library(crask SHARED src/crask.cpp)
add_executable(crask_ut test/main.cpp test/classes.cpp)
add_executable(crask_demo test/demo.c)
target_link_libraries(crask_ut crask gmock pthread)
target_link_libraries(crask_demo crask)
