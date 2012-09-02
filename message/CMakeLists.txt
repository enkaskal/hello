project(message)

set(dependencies "")

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp" "include/*.h")

add_library(${PROJECT_NAME} STATIC ${src_files})

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")

# EOF 


