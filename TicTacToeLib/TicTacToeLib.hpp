#ifndef TICTACTOELIB_H
#define TICTACTOELIB_H

#include<qqml.h>

void registerQMLItems()
{
    Q_INIT_RESOURCE(TicTacToe);
    qmlRegisterSingletonType(QUrl("qrc:/TicTacToeLib/Theme.qml"), "Theme", 1, 0, "Theme");
}

#endif // TICTACTOELIB_H
