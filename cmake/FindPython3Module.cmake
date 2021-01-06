# ------------------------------------------------------------------------------
# FindPython3Module
#
# based on: 
#   https://cmake.org/pipermail/cmake/2011-January/041666.html
# and
#   https://github.com/arbor-sim/arbor/blob/master/cmake/FindPythonModule.cmake
# 
# ------------------------------------------------------------------------------
include(FindPython3)
include(FindPackageHandleStandardArgs)

function(find_python3_module module)
    string(TOUPPER ${module} module_upper)

    if(NOT PY_${module_upper})
        if(ARGC GREATER 1 AND ARGV1 STREQUAL "REQUIRED")
            set(PY_${module_upper}_FIND_REQUIRED TRUE)
        endif()

        # python modules are located on a directory
        # notwithstading, binary modules are a .so file
        execute_process(COMMAND "${Python3_EXECUTABLE}" "-c"
            "import re, ${module}; print(re.compile('/__init__.py.*').sub('',${module}.__file__))"
            RESULT_VARIABLE _${module}_status
            OUTPUT_VARIABLE _${module}_location
            ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

        if(NOT _${module}_status)
            set(HAVE_${module_upper} ON CACHE INTERNAL "Python module available")
            set(PY_${module_upper} ${_${module}_location} CACHE STRING "Location of Python module ${module}")
        else()
            set(HAVE_${module_upper} OFF CACHE INTERNAL "Python module available")
        endif()

    endif(NOT PY_${module_upper})

    find_package_handle_standard_args(
        # ACL
            PY_${module_upper} 
        # Use default message on fail.
            DEFAULT_MSG 
        # Variables which should be true-evaluated to assume the package to be found
        PY_${module_upper})
endfunction(find_python3_module)
