CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# Project's name
PROJECT(StaticLibHtm)

IF(NOT CMAKE_BUILD_TYPE)
	SET(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build, options are: None Debug GProf Valgrind Release RelWithDebInfo MinSizeRel." FORCE)
ENDIF()

#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -WALL -O2 -fPIC -std=c++0x")
SET(CMAKE_CXX_STANDARD 11)
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

add_definitions(-DLINKAGE=)

include_directories(${CMAKE_SOURCE_DIR}/include)

file(GLOB_RECURSE HtmSrc
	./src/*.cpp)
add_library(SpatialIndex STATIC ${HtmSrc})