project(hello-java Java)

set (dependencies "")

file(GLOB src_files "src/net/cryp7/range/hello/*.java")

find_package(Java)
include(UseJava)

# fyi, currently must be before add_jar...
# which makes dependencies a pain!
# so for now we're going to have a separate java dependency handler
include (${CMAKE_BUILD_ROOT}/include/java-dependencies.cmake)

set(CMAKE_JAVA_TARGET_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH})
add_jar(${PROJECT_NAME} ${src_files})

install_jar(${PROJECT_NAME} lib)
if (WIN32)
install(FILES distrib/hello-java.bat DESTINATION bin)
else()
install(FILES distrib/hello-java.sh DESTINATION bin PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endif()

include ("${CMAKE_BUILD_ROOT}/include/project.cmake")
