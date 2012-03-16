project(hello)

set(dependencies "")
set(dependencies ${dependencies} output)

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp")

add_executable(${PROJECT_NAME} ${src_files})

include ("${CMAKE_SOURCE_DIR}/project.cmake")





