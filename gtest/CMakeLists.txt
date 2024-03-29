########################################################################
# Experimental CMake build script for Google Test.
#
# Consider this a prototype.  It will change drastically.  For now,
# this is only for people on the cutting edge.
#
# To run the tests for Google Test itself on Linux, use 'make test' or
# ctest.  You can select which tests to run using 'ctest -R regex'.
# For more options, run 'ctest --help'.

# For hermetic builds, we may need to tell CMake to use compiler in a
# specific location.
if (gtest_compiler)
  include(CMakeForceCompiler)
  cmake_force_c_compiler("${gtest_compiler}" "")
  cmake_force_cxx_compiler("${gtest_compiler}" "")
endif()

########################################################################
#
# Project-wide settings

# Name of the project.
#
# CMake files in this project can refer to the root source directory
# as ${gtest_SOURCE_DIR} and to the root binary directory as
# ${gtest_BINARY_DIR}.
# Language "C" is required for find_package(Threads).
project(gtest CXX C)
cmake_minimum_required(VERSION 2.6.4)

if (MSVC)
  # For MSVC, CMake sets certain flags to defaults we want to override.
  # This replacement code is taken from sample in the CMake Wiki at
  # http://www.cmake.org/Wiki/CMake_FAQ#Dynamic_Replace.
  foreach (flag_var
           CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
           CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    # In hermetic build environments, tests may not have access to MS runtime
    # DLLs, so this replaces /MD (CRT libraries in DLLs) with /MT (static CRT
    # libraries).
    #string(REPLACE "/MD" "-MT" ${flag_var} "${${flag_var}}")
    # We prefer more strict warning checking for building Google Test.
    # Replaces /W3 with /W4 in defaults.
    string(REPLACE "/W3" "-W4" ${flag_var} "${${flag_var}}")
  endforeach()
endif()

# Where gtest's .h files can be found.
include_directories(
  ${gtest_SOURCE_DIR}/include
  ${gtest_SOURCE_DIR})

# Where the gtest libraries can be found.
link_directories(
  ${gtest_BINARY_DIR}/src)

# Defines CMAKE_USE_PTHREADS_INIT and CMAKE_THREAD_LIBS_INIT.
find_package(Threads)

# Defines the compiler/linker flags used to build gtest.  You can
# tweak these definitions to suit your need.  A variable's value is
# empty before it's explicitly assigned to.

if (MSVC)
  # Newlines inside flags variables break CMake's NMake generator.
  set(cxx_base_flags "-GS -W4 -WX -wd4275 -nologo -J -Zi")
  set(cxx_base_flags "${cxx_base_flags} -D_UNICODE -DUNICODE -DWIN32 -D_WIN32")
  set(cxx_base_flags "${cxx_base_flags} -DSTRICT -DWIN32_LEAN_AND_MEAN")
  set(cxx_exception_flags "-EHsc -D_HAS_EXCEPTIONS=1")
  set(cxx_no_exception_flags "-D_HAS_EXCEPTIONS=0")
  set(cxx_no_rtti_flags "-GR-")
elseif (CMAKE_COMPILER_IS_GNUCXX)
  set(cxx_base_flags "-Wall -Wshadow")
  set(cxx_exception_flags "-fexceptions")
  set(cxx_no_exception_flags "-fno-exceptions")
  # Until version 4.3.2, GCC doesn't define a macro to indicate
  # whether RTTI is enabled.  Therefore we define GTEST_HAS_RTTI
  # explicitly.
  set(cxx_no_rtti_flags "-fno-rtti -DGTEST_HAS_RTTI=0")
  set(cxx_strict_flags "-Wextra")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "SunPro")
  set(cxx_exception_flags "-features=except")
  # Sun Pro doesn't provide macros to indicate whether exceptions and
  # RTTI are enabled, so we define GTEST_HAS_* explicitly.
  set(cxx_no_exception_flags "-features=no%except -DGTEST_HAS_EXCEPTIONS=0")
  set(cxx_no_rtti_flags "-features=no%rtti -DGTEST_HAS_RTTI=0")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "VisualAge" OR
        CMAKE_CXX_COMPILER_ID STREQUAL "XL")
  # CMake 2.8 changes Visual Age's compiler ID to "XL".
  set(cxx_exception_flags "-qeh")
  set(cxx_no_exception_flags "-qnoeh")
  # Until version 9.0, Visual Age doesn't define a macro to indicate
  # whether RTTI is enabled.  Therefore we define GTEST_HAS_RTTI
  # explicitly.
  set(cxx_no_rtti_flags "-qnortti -DGTEST_HAS_RTTI=0")
endif()

if (CMAKE_USE_PTHREADS_INIT)  # The pthreads library is available.
  set(cxx_base_flags "${cxx_base_flags} -DGTEST_HAS_PTHREAD=1")
endif()

# For building gtest's own tests and samples.
set(cxx_exception "${CMAKE_CXX_FLAGS} ${cxx_base_flags} ${cxx_exception_flags}")
set(cxx_no_exception
    "${CMAKE_CXX_FLAGS} ${cxx_base_flags} ${cxx_no_exception_flags}")
set(cxx_default "${cxx_exception}")
set(cxx_no_rtti "${cxx_default} ${cxx_no_rtti_flags}")
set(cxx_use_own_tuple "${cxx_default} -DGTEST_USE_OWN_TR1_TUPLE=1")

# For building the gtest libraries.
set(cxx_strict "${cxx_default} ${cxx_strict_flags}")

########################################################################
#
# Defines the gtest & gtest_main libraries.  User tests should link
# with one of them.
function(cxx_library_with_type name type cxx_flags)
  # type can be either STATIC or SHARED to denote a static or shared library.
  # ARGN refers to additional arguments after 'cxx_flags'.
  add_library(${name} ${type} ${ARGN})
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${cxx_flags}")
    if (CMAKE_USE_PTHREADS_INIT)
      target_link_libraries(${name} ${CMAKE_THREAD_LIBS_INIT})
    endif()
endfunction()

function(cxx_static_library name cxx_flags)
  cxx_library_with_type(${name} STATIC "${cxx_flags}" ${ARGN})
endfunction()

function(cxx_shared_library name cxx_flags)
  cxx_library_with_type(${name} SHARED "${cxx_flags}" ${ARGN})
endfunction()

function(cxx_library name cxx_flags)
  # TODO(vladl@google.com): Make static/shared a user option.
  cxx_static_library(${name} "${cxx_flags}" ${ARGN})
endfunction()

# Static versions of Google Test libraries.  We build them using more
# strict warnings than what are used for other targets, to ensure that
# gtest can be compiled by a user aggressive about warnings.
cxx_static_library(gtest "${cxx_strict}" src/gtest-all.cc)
cxx_static_library(gtest_main "${cxx_strict}" src/gtest_main.cc)
target_link_libraries(gtest_main gtest)

########################################################################
#
# Samples on how to link user tests with gtest or gtest_main.
#
# They are not built by default.  To build them, set the
# build_gtest_samples option to ON.  You can do it by running ccmake
# or specifying the -Dbuild_gtest_samples=ON flag when running cmake.

option(build_gtest_samples "Build gtest's sample programs." OFF)

# cxx_executable_with_flags(name cxx_flags lib srcs...)
#
# creates a named C++ executable that depends on the given library and
# is built from the given source files with the given compiler flags.
function(cxx_executable_with_flags name cxx_flags lib)
  add_executable(${name} ${ARGN})
  if (cxx_flags)
    set_target_properties(${name}
      PROPERTIES
      COMPILE_FLAGS "${cxx_flags}")
  endif()
  target_link_libraries(${name} ${lib})
endfunction()

# cxx_executable(name dir lib srcs...)
#
# creates a named target that depends on the given lib and is built
# from the given source files.  dir/name.cc is implicitly included in
# the source file list.
function(cxx_executable name dir lib)
  cxx_executable_with_flags(
    ${name} "${cxx_default}" ${lib} "${dir}/${name}.cc" ${ARGN})
endfunction()

if (build_gtest_samples)
  cxx_executable(sample1_unittest samples gtest_main samples/sample1.cc)
  cxx_executable(sample2_unittest samples gtest_main samples/sample2.cc)
  cxx_executable(sample3_unittest samples gtest_main)
  cxx_executable(sample4_unittest samples gtest_main samples/sample4.cc)
  cxx_executable(sample5_unittest samples gtest_main samples/sample1.cc)
  cxx_executable(sample6_unittest samples gtest_main)
  cxx_executable(sample7_unittest samples gtest_main)
  cxx_executable(sample8_unittest samples gtest_main)
  cxx_executable(sample9_unittest samples gtest)
  cxx_executable(sample10_unittest samples gtest)
endif()

########################################################################
#
# Google Test's own tests.
#
# You can skip this section if you aren't interested in testing
# Google Test itself.
#
# Most of the tests are not built by default.  To build them, set the
# build_all_gtest_tests option to ON.  You can do it by running ccmake
# or specifying the -Dbuild_all_gtest_tests=ON flag when running cmake.

option(build_all_gtest_tests "Build all of gtest's own tests." OFF)

# This must be set in the root directory for the tests to be run by
# 'make test' or ctest.
enable_testing()

# Sets PYTHONINTERP_FOUND and PYTHON_EXECUTABLE.
find_package(PythonInterp)

############################################################
# C++ tests built with standard compiler flags.

# cxx_test_with_flags(name cxx_flags libs srcs...)
#
# creates a named C++ test that depends on the given libs and is built
# from the given source files with the given compiler flags.
function(cxx_test_with_flags name cxx_flags libs)
  add_executable(${name} ${ARGN})
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${cxx_flags}")
  # To support mixing linking in static and dynamic libraries, link each
  # library in with an extra call to target_link_libraries.
  foreach (lib "${libs}")
    target_link_libraries(${name} ${lib})
  endforeach()
  add_test(${name} ${name})
endfunction()

# cxx_test(name libs srcs...)
#
# creates a named test target that depends on the given libs and is
# built from the given source files.  Unlike cxx_test_with_flags,
# test/name.cc is already implicitly included in the source file list.
function(cxx_test name libs)
  cxx_test_with_flags("${name}" "${cxx_default}" "${libs}"
    "test/${name}.cc" ${ARGN})
endfunction()

cxx_test(gtest_unittest gtest_main)

if (build_all_gtest_tests)
  cxx_test(gtest-death-test_test gtest_main)
  cxx_test(gtest_environment_test gtest)
  cxx_test(gtest-filepath_test gtest_main)
  cxx_test(gtest-linked_ptr_test gtest_main)
  cxx_test(gtest-listener_test gtest_main)
  cxx_test(gtest_main_unittest gtest_main)
  cxx_test(gtest-message_test gtest_main)
  cxx_test(gtest_no_test_unittest gtest)
  cxx_test(gtest-options_test gtest_main)
  cxx_test(gtest-param-test_test gtest
    test/gtest-param-test2_test.cc)
  cxx_test(gtest-port_test gtest_main)
  cxx_test(gtest_pred_impl_unittest gtest_main)
  cxx_test(gtest_prod_test gtest_main
    test/production.cc)
  cxx_test(gtest_repeat_test gtest)
  cxx_test(gtest_sole_header_test gtest_main)
  cxx_test(gtest_stress_test gtest)
  cxx_test(gtest-test-part_test gtest_main)
  cxx_test(gtest_throw_on_failure_ex_test gtest)
  cxx_test(gtest-typed-test_test gtest_main
    test/gtest-typed-test2_test.cc)
  cxx_test(gtest-unittest-api_test gtest)
endif()

############################################################
# C++ tests built with non-standard compiler flags.

if (build_all_gtest_tests)
  cxx_library(gtest_no_exception "${cxx_no_exception}"
    src/gtest-all.cc)
  cxx_library(gtest_main_no_rtti "${cxx_no_rtti}"
    src/gtest-all.cc src/gtest_main.cc)

  cxx_test_with_flags(gtest_no_rtti_unittest "${cxx_no_rtti}"
    gtest_main_no_rtti test/gtest_unittest.cc)

  set(cxx_use_shared_gtest "${cxx_default} -DGTEST_LINKED_AS_SHARED_LIBRARY=1")
  set(cxx_build_shared_gtest "${cxx_default} -DGTEST_CREATE_SHARED_LIBRARY=1")
  if (MSVC)
    # Disables the "class 'X' needs to have dll-interface to be used
    # by clients of class 'Y'" warning. This particularly concerns generic
    # classes like vector that MS doesn't mark as exported.
    set(cxx_use_shared_gtest "${cxx_use_shared_gtest} -wd4251")
    set(cxx_build_shared_gtest "${cxx_build_shared_gtest} -wd4251")
  endif()

  cxx_shared_library(gtest_dll "${cxx_build_shared_gtest}"
    src/gtest-all.cc)

  # TODO(vladl): This and the next tests may not run in the hermetic
  # environment on Windows. Re-evaluate and possibly make them
  # platform-conditional after implementing hermetic builds.
  cxx_executable_with_flags(gtest_dll_test_ "${cxx_use_shared_gtest}"
    gtest_dll test/gtest_all_test.cc)

  if (NOT(MSVC AND (MSVC_VERSION EQUAL 1600)))
    # The C++ Standard specifies tuple_element<int, class>.
    # Yet MSVC 10's <utility> declares tuple_element<size_t, class>.
    # That declaration conflicts with our own standard-conforming
    # tuple implementation.  Therefore using our own tuple with
    # MSVC 10 doesn't compile.
    cxx_library(gtest_main_use_own_tuple "${cxx_use_own_tuple}"
      src/gtest-all.cc src/gtest_main.cc)

    cxx_test_with_flags(gtest-tuple_test "${cxx_use_own_tuple}"
      gtest_main_use_own_tuple test/gtest-tuple_test.cc)

    cxx_test_with_flags(gtest_use_own_tuple_test "${cxx_use_own_tuple}"
      gtest_main_use_own_tuple
      test/gtest-param-test_test.cc test/gtest-param-test2_test.cc)
  endif()

endif()

############################################################
# Python tests.

# py_test(name)
#
# creates a Python test with the given name whose main module is in
# test/name.py.  It does nothing if Python is not installed.
function(py_test name)
  if (PYTHONINTERP_FOUND)
    # ${gtest_BINARY_DIR} is known at configuration time, so we can
    # directly bind it from cmake. ${CTEST_CONFIGURATION_TYPE} is known
    # only at ctest runtime (by calling ctest -c <Configuration>), so
    # we have to escape $ to delay variable substitution here.
    add_test(${name}
      ${PYTHON_EXECUTABLE} ${gtest_SOURCE_DIR}/test/${name}.py
          --gtest_build_dir=${gtest_BINARY_DIR}/\${CTEST_CONFIGURATION_TYPE})
  endif()
endfunction()

if (build_all_gtest_tests)
  cxx_executable(gtest_break_on_failure_unittest_ test gtest)
  py_test(gtest_break_on_failure_unittest)

  cxx_executable(gtest_color_test_ test gtest)
  py_test(gtest_color_test)

  cxx_executable(gtest_env_var_test_ test gtest)
  py_test(gtest_env_var_test)

  cxx_executable(gtest_filter_unittest_ test gtest)
  py_test(gtest_filter_unittest)

  cxx_executable(gtest_help_test_ test gtest_main)
  py_test(gtest_help_test)

  cxx_executable(gtest_list_tests_unittest_ test gtest)
  py_test(gtest_list_tests_unittest)

  cxx_executable(gtest_output_test_ test gtest)
  py_test(gtest_output_test)

  cxx_executable(gtest_shuffle_test_ test gtest)
  py_test(gtest_shuffle_test)

  cxx_executable(gtest_throw_on_failure_test_ test gtest_no_exception)
  set_target_properties(gtest_throw_on_failure_test_
    PROPERTIES
    COMPILE_FLAGS "${cxx_no_exception}")
  py_test(gtest_throw_on_failure_test)

  cxx_executable(gtest_uninitialized_test_ test gtest)
  py_test(gtest_uninitialized_test)

  cxx_executable(gtest_xml_outfile1_test_ test gtest_main)
  cxx_executable(gtest_xml_outfile2_test_ test gtest_main)
  py_test(gtest_xml_outfiles_test)

  cxx_executable(gtest_xml_output_unittest_ test gtest)
  py_test(gtest_xml_output_unittest)
endif()
