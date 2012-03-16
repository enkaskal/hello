project(message)

set(dependencies "")

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp")

add_library(${PROJECT_NAME} STATIC ${src_files})

include ("${CMAKE_SOURCE_DIR}/project.cmake")



