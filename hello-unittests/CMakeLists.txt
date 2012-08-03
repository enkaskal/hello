project(hello-unittests)

set(dependencies "")
set(dependencies ${dependencies} gtest)
set(dependencies ${dependencies} message)
set(dependencies ${dependencies} output)

file (GLOB dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*")

set(src_groups "")
foreach(dir ${dirs})
	if(IS_DIRECTORY ${dir})
		file (GLOB group_files "${dir}/*.c" "${dir}/*.cc" "${dir}/*.cpp")
		source_group(${dir} FILES ${group_files})
		#message(STATUS "${dir}: ${group_files}")
		set(src_groups ${src_groups} ${group_files})
	endif()
endforeach()

#message(STATUS "adding the following unittests: ${src_groups}")
add_executable(${PROJECT_NAME} main.cc ${src_groups})

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")

# EOF 
