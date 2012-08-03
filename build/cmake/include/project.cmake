# for now handle as an include in each project
# this could probably be done as a cmake macro as well

set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "_d")
get_target_property(target_type ${PROJECT_NAME} TYPE)

if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
if(CMAKE_SYSTEM_NAME STREQUAL "SunOS")
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-mimpure-text")
endif()
endif()

if ( ${target_type} STREQUAL "SHARED_LIBRARY" )
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "lib")
set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".so")
endif()

set(include_files "include")

foreach (dependency ${dependencies})
	set(include_files ${include_files} "${CMAKE_SOURCE_DIR}/${dependency}/include")
endforeach (dependency ${dependencies})

include_directories(${include_files})

if (dependencies)
	add_dependencies(${PROJECT_NAME} ${dependencies})
	if ( NOT ${target_type} STREQUAL "UTILITY")
		target_link_libraries (${PROJECT_NAME} ${dependencies})
	endif()
endif()

include (${CMAKE_BUILD_ROOT}/include/compilers.cmake)

# EOF

