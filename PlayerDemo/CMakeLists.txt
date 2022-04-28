cmake_minimum_required(VERSION 3.16)

project(PlayerDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 6.2 COMPONENTS Multimedia REQUIRED)

file(GLOB_RECURSE source_files *.c *.cpp)
file(GLOB_RECURSE header_files *.h *.hpp)

include_directories(${header_files})

qt_add_executable(appPlayerDemo
    main.cpp
    qml.qrc
    ${source_files}
    ${header_files}
)

#qt_add_qml_module(appPlayerDemo
#    URI PlayerDemo
#    VERSION 1.0
#    QML_FILES main.qml
#)

set_target_properties(appPlayerDemo PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appPlayerDemo
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appPlayerDemo
    PRIVATE Qt6::Quick Qt6::Multimedia)
