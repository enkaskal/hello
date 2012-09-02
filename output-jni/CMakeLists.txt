project(output-jni)

set(dependencies "")
set(dependencies ${dependencies} output)

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp" "include/*.h")

add_library(${PROJECT_NAME} SHARED ${src_files})
install(TARGETS ${PROJECT_NAME} DESTINATION lib)

find_package(JNI)

include_directories(${JNI_INCLUDE_DIRS})

#set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER "blah")

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")
