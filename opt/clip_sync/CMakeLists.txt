#

cmake_minimum_required(VERSION 4.0)
project(clip_sync)

add_executable(main main.cpp)

find_package(PkgConfig REQUIRED)
pkg_check_modules(MODULES REQUIRED x11 gtk+-3.0)

message("MODULES_INCLUDE_DIRS: ${MODULES_INCLUDE_DIRS}")
target_include_directories(main PUBLIC
    ${MODULES_INCLUDE_DIRS}
)
message("MODULES_LIBRARY_DIRS: ${MODULES_LIBRARY_DIRS}")
target_link_libraries(main PUBLIC
    ${MODULES_LIBRARIES}
)
