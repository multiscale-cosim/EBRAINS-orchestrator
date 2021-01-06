# ------------------------------------------------------------------------------
# Forschungszentrum Jülich
#  Institute: Institute for Advanced Simulation (IAS)
#    Section: Jülich Supercomputing Centre (JSC)
#   Division: High Performance Computing in Neuroscience
# Laboratory: Simulation Laboratory Neuroscience
#       Team: Multiscale Simulation and Design
#
#   Date: 2020.12.16
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------
project(EBRAINS-orchestrator)
cmake_minimum_required(VERSION 3.12)

# ------------------------------------------------------------------------------
# Prerequisites checking
# ------------------------------------------------------------------------------
find_package(MPI REQUIRED)
find_package(Python3 REQUIRED)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(FindPython3Module)
find_python3_module(mpi4py REQUIRED)
find_python3_module(elephant REQUIRED)
find_python3_module(tvb REQUIRED)

# ------------------------------------------------------------------------------
# NEST checking
# ------------------------------------------------------------------------------
include(CheckNEST)
check_NEST()

#install(DIRECTORY DESTINATION ${CMAKE_INSTALL_PREFIX})
install(DIRECTORY launcher/ DESTINATION ${CMAKE_INSTALL_PREFIX}/launcher) # Trailing slash is important!
