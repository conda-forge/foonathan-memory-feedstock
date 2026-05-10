cmake_minimum_required(VERSION 3.14)

project(foonathan_memory_consumer LANGUAGES CXX)

find_package(foonathan_memory CONFIG REQUIRED)

add_executable(foonathan_memory_consumer test_package.cpp)
target_link_libraries(foonathan_memory_consumer PRIVATE foonathan_memory)
