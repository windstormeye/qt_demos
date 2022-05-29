cmake_minimum_required(VERSION 3.16)

project(ImageEditor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

file(GLOB_RECURSE sources *.cpp)
file(GLOB_RECURSE headers *.h)
file(GLOB_RECURSE qmls *.qml)

foreach(filepath ${qmls})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath}) #.+/(.+)\\\\..*" "\\\\1
    list(APPEND qml_files ${filename})
endforeach(filepath)

qt_add_executable(appImageEditor
    main.cpp
    ${sources}
    ${headers}
    ${qml_files}
)

qt_add_qml_module(appImageEditor
    URI ImageEditor
    VERSION 1.0
    QML_FILES ${qml_files}
)

source_group(TREE ${PROJECT_SOURCE_DIR} FILES ${headers} ${sources} ${qmls})


set_target_properties(appImageEditor PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appImageEditor
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appImageEditor
    PRIVATE Qt6::Quick)
