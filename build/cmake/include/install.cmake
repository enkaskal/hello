set(VERSION "0.0.0")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")

set(CPACK_GENERATOR "ZIP")

install (FILES distrib/README.txt DESTINATION .)

include(CPack)
include(InstallRequiredSystemLibraries)

#EOF
