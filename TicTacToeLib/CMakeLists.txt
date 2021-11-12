project(TicTacToeLib)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)
set(LIBRARIES
        Qt5::Core
        Qt5::Quick)

set (QML_IMPORT_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    CACHE STRING
    ""
    FORCE)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(QRC    TicTacToe.qrc)
qt5_add_resources(RESOURCE_ADDED ${QRC})

add_library(${PROJECT_NAME} SHARED ${RESOURCE_ADDED} TicTacToeLib.hpp)
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})
