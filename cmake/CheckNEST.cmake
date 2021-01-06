# ------------------------------------------------------------------------------
# Forschungszentrum Jülich
#  Institute: Institute for Advanced Simulation (IAS)
#    Section: Jülich Supercomputing Centre (JSC)
#   Division: High Performance Computing in Neuroscience
# Laboratory: Simulation Laboratory Neuroscience
#       Team: Multiscale Simulation and Design
#
#   Date: 2020.12.21
# ------------------------------------------------------------------------------

function(check_NEST)
    if(NOT DEFINED NEST_INSTALLATION_PATH)
        message(FATAL_ERROR
            "NEST installation path has not been specified\n"
            "please add -DNEST_INSTALLATION_PATH=/path/to/nest")
    endif(NOT DEFINED NEST_INSTALLATION_PATH)

    if(NOT EXISTS ${NEST_INSTALLATION_PATH})
        message(FATAL_ERROR 
            "The specified NEST installation path:\n"
            "${NEST_INSTALLATION_PATH}\n"
            "DOES NOT EXIST")
    endif(NOT EXISTS ${NEST_INSTALLATION_PATH})

    if(NOT IS_DIRECTORY ${NEST_INSTALLATION_PATH})
        message(FATAL_ERROR 
            "The specified NEST installation path:\n"
            "${NEST_INSTALLATION_PATH}\n"
            "is not a directory!\n"
            "NOTE: please specify the path where NEST is installed.\n"
            "WARNING: the path should refer to the NEST top-level installation directory.\n"
            "e.g. /opt/ebrains/nest")
    endif(NOT IS_DIRECTORY ${NEST_INSTALLATION_PATH})

    set(NEST_SITE_PACKAGES_PATH "${NEST_INSTALLATION_PATH}/lib/python${Python3_VERSION_MAJOR}.${Python3_VERSION_MINOR}/site-packages")
    set(NEST_PYTHON_PACKAGE_PATH "${NEST_SITE_PACKAGES_PATH}/nest")

    if(NOT EXISTS ${NEST_PYTHON_PACKAGE_PATH})
        message(FATAL_ERROR 
            "There is no NEST's python package on:\n"
            "${NEST_SITE_PACKAGES_PATH}\n"
            "${NEST_PYTHON_PACKAGE_PATH} DOES NOT EXIST")
    endif(NOT EXISTS ${NEST_PYTHON_PACKAGE_PATH})

    message(STATUS "Found NEST's python packages: ${NEST_SITE_PACKAGES_PATH}")

    execute_process(COMMAND "${Python3_EXECUTABLE}" "-c"
        "import sys; sys.path.append('${NEST_SITE_PACKAGES_PATH}'); import nest"
        RESULT_VARIABLE _checking_import_nest_result_variable
        OUTPUT_VARIABLE _checking_import_nest_output_variable
        ERROR_VARIABLE _checking_import_nest_error_variable
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    #ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

    if(_checking_import_nest_result_variable AND NOT _checking_import_nest_result_variable EQUAL 0)
        message("\nimport nest ERROR\n${_checking_import_nest_output_variable}")
        message(FATAL_ERROR ${_checking_import_nest_error_variable})
    endif()
    #if(NOT _${module}_status)
    #set(HAVE_${module_upper} ON CACHE INTERNAL "")
    #set(PY_${module_upper} ${_${module}_location} CACHE STRING
    #"Location of Python module ${module}")
    #else()
    #set(HAVE_${module_upper} OFF CACHE INTERNAL "")
    #endif()
endfunction(check_NEST)




