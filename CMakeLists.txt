cmake_minimum_required(VERSION 3.5)
project(alpha_demo)
set(CMAKE_CXX_STANDARD 11)

include_directories(${Tesseract_INCLUDE_DIRS})

add_executable(alpha_demo main.cpp)

target_link_libraries(alpha_demo ${Tesseract_LIBRARIES})
target_link_libraries(alpha_demo -llept -ltesseract)
