cmake_minimum_required(VERSION 3.21)

set(PRJ_VERSION 1.0.0)
message(STATUS "AppContrastRectangle VERSION  : " ${PRJ_VERSION})

# ====================================================================
# Declare project
# ====================================================================
set(TARGET_PROJECT AppContrastRectangle)

qt_standard_project_setup(REQUIRES 6.8)
qt_policy(SET QTP0001 NEW)

project(${TARGET_PROJECT} LANGUAGES CXX VERSION ${PRJ_VERSION})

# ====================================================================
# Set sources
# ====================================================================
list(APPEND  target_headers
    include/AppContrastRectangle/version.hpp
    include/AppContrastRectangle/main.hpp
    # TODO: your header files.
)

list(APPEND target_src
    src/AppContrastRectangle/main.cpp
    # TODO: your src files.
)

# ====================================================================
# TARGET
# ====================================================================

# Define essential applications routine as library.
# This will allow us to use it in tests, thus we can do testing
# the same way as with libraries.
qt_add_library(${TARGET_PROJECT}_lib STATIC ${target_headers} ${target_src})
add_library(AppContrastRectangle::AppContrastRectangle_lib ALIAS ${TARGET_PROJECT}_lib)

set_target_properties(
    ${TARGET_PROJECT}_lib PROPERTIES
    VERSION ${PRJ_VERSION}
    SOVERSION ${PRJ_VERSION_MAJOR}.${PRJ_VERSION_MINOR}
)

set(PROJECT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
message(STATUS "${TARGET_PROJECT}_lib include dir: ${PROJECT_INCLUDE_DIR}")
target_include_directories(${TARGET_PROJECT}_lib PUBLIC ${PROJECT_INCLUDE_DIR})

# Remove entries (and related files) that are not needed.
qt_add_qml_module(${TARGET_PROJECT}_lib
    URI AppContrastRectangle
    VERSION 1.0
    QML_FILES
        # Actual window to open.
        qml/MyMainWindow.qml
    RESOURCE_PREFIX "/"
    NO_PLUGIN
)

target_link_libraries(${TARGET_PROJECT}_lib PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
)

qt_import_qml_plugins(${TARGET_PROJECT}_lib)

qt_add_executable(${TARGET_PROJECT} src/main.cpp)

# A final executable:
target_link_libraries(
    ${TARGET_PROJECT}
    PRIVATE
    AppContrastRectangle::AppContrastRectangle_lib
)
