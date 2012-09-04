project(hello)

set(dependencies "")
#set(dependencies ${dependencies} output) #lazy loaded now!

file(GLOB src_files "src/*.c" "src/*.cc" "src/*.cpp" "include/*.h")

include_directories(${PRODUCT_SOURCE_DIR}/output/include)

add_executable(${PROJECT_NAME} ${src_files})
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")

# EOF 






