project(output)

set(dependencies "")
set(dependencies ${dependencies} message)

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp")

add_definitions(-DEXPORT_API)

add_library(${PROJECT_NAME} SHARED ${src_files})

include ("${CMAKE_SOURCE_DIR}/project.cmake")


