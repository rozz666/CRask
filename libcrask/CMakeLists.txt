project(libcrask)

cmake_minimum_required(VERSION 2.8)

include_directories("include" "gmock-1.6.0/fused-src")

add_library(gmock gmock-1.6.0/fused-src/gmock-gtest-all.cc)
add_library(crask src/crask.cpp)
add_executable(crask_ut test/main.cpp)
target_link_libraries(crask_ut gmock pthread)