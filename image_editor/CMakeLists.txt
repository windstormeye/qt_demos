cmake_minimum_required(VERSION 3.16)

project(image_editor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# 开启 qrc 资源自动管理
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

file(GLOB_RECURSE source_files *.c *.cpp)
file(GLOB_RECURSE header_files *.h *.hpp)

qt_add_executable(appimage_editor
    resources.qrc
    ${source_files}
    ${header_files}
)

set_target_properties(appimage_editor PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appimage_editor
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appimage_editor
    PRIVATE Qt6::Quick)
