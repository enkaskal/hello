cmake_minimum_required (VERSION 2.6)

project (hello)

set(CMAKE_VERBOSE_MAKEFILE TRUE)

message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")

include (compilers.cmake)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/artifacts)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/artifacts)

set( components "" )
set( components ${components} hello )
set( components ${components} message )
set( components ${components} output )
set( components ${components} gtest )
set( components ${components} hello-unittests )

foreach (component ${components})
	add_subdirectory ( ${component} )
	#message(STATUS "component: ${component}")
endforeach ( component ${components} )

