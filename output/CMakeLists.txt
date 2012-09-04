project(output)

set(dependencies "")
set(dependencies ${dependencies} message)

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp" "include/*.h")

add_definitions(-DEXPORT_API)

add_library(${PROJECT_NAME} SHARED ${src_files})
install(TARGETS ${PROJECT_NAME} DESTINATION lib)

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")

# EOF 
