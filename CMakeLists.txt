cmake_minimum_required(VERSION 3.7)

project(vsgExamples
        VERSION 0.0.0
        DESCRIPTION "Set of example programs that test and illustrate how to use the Vulkan/VkSceneGraph"
        LANGUAGES CXX C
)

# build all examples into the bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# Change the default build type to Release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif(NOT CMAKE_BUILD_TYPE)

# find the vsg
if (VULKAN_SDK)
    set(ENV{VULKAN_SDK} ${VULKAN_SDK})
endif()

find_package(vsg REQUIRED)

# find the optional vsgXchange that can be used for reading and range of image and 3d model formats and shader compilation
find_package(vsgXchange QUIET)

# find the optional vsgImGui that can be used for GUI elements added into graphics window.
find_package(vsgImGui QUIET)

# set the use of C++17 globally as all examples require it
set(CMAKE_CXX_STANDARD 17)

# add clobber build target to clear all the non git registered files/directories
add_custom_target(clobber
    COMMAND git clean -d -f -x
)

# add clang-foramt build target to enforce a standard code style guide.
find_program(CLANGFORMAT clang-format)
if (CLANGFORMAT)
    add_custom_target(clang-format
        COMMAND ${CLANGFORMAT} -i ${CMAKE_SOURCE_DIR}/*/*/*.h ${CMAKE_SOURCE_DIR}/*/*/*.cpp ${CMAKE_SOURCE_DIR}/*/*/*/*.h ${CMAKE_SOURCE_DIR}/*/*/*/*.cpp
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Automated code format using clang-format"
    )
endif()

# pure VSG examples
add_subdirectory(examples/core)
add_subdirectory(examples/maths)
add_subdirectory(examples/io)
add_subdirectory(examples/ui)
add_subdirectory(examples/state)
add_subdirectory(examples/commands)
add_subdirectory(examples/nodes)
add_subdirectory(examples/traversals)
add_subdirectory(examples/threading)
add_subdirectory(examples/viewer)
add_subdirectory(examples/vk)
add_subdirectory(examples/text)
add_subdirectory(examples/raytracing)
add_subdirectory(examples/introspection)
add_subdirectory(examples/platform)
