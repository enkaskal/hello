#######################################################
# include for all projects that need Berkeley sockets #
#######################################################

if ( MSVC OR MSVC_IDE )
target_link_libraries (${PROJECT_NAME} "ws2_32.lib")
else()
# this is handled with *nix systems automatically
endif()

# EOF 
