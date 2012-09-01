cmake_minimum_required (VERSION 2.8.4)

project (hello)

set_property(GLOBAL PROPERTY USE_FOLDERS OFF)

message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/artifacts)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/artifacts)
set(PRODUCT_SOURCE_DIR ${CMAKE_SOURCE_DIR})
set(CMAKE_BUILD_ROOT ${PRODUCT_SOURCE_DIR}/build/cmake)

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

