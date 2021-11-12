project(TicTacToe LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)
set( LIBRARIES
    Qt5::Core
    Qt5::Quick
    TicTacToeLib
    )

file (GLOB_RECURSE SRC "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file (GLOB_RECURSE RC "${CMAKE_CURRENT_SOURCE_DIR}/*.qrc")
qt5_add_resources(RESOURCE_ADDED ${RC})


add_executable(${PROJECT_NAME} ${SRC} ${RESOURCE_ADDED} )
#target_compile_definitions(${PROJECT_NAME}
#    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME} ${LIBRARIES} )
