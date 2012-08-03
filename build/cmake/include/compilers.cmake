
if (MSVC OR MSVC_IDE)
add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
add_definitions(-D_SCL_SECURE_NO_WARNINGS)

SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -MD ")
SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -MD ")

SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -ZI -Od -MDd")
SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -ZI -Od -MDd")

if ( NOT ALLOW_WARNINGS )
	add_definitions(-WX)
endif()

endif()

if (CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX )
if ( NOT ALLOW_WARNINGS )
	SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Werror")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror")
endif()

target_link_libraries(${PROJECT_NAME} dl)
if ( ${target_type} STREQUAL "STATIC_LIBRARY" )
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
endif()
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffloat-store")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffloat-store")

if(CMAKE_SYSTEM_NAME STREQUAL "SunOS")
set_property(GLOBAL PROPERTY LINK_FLAGS "${LINK_FLAGS} -mimpure-text")
endif()

if (UNIX)
target_link_libraries(${PROJECT_NAME} pthread m)
endif(UNIX)

endif()

# EOF
