import QtQuick 2.15
import QtQuick.Window 2.15
import TicTacToeLib 1.0

Window {
    id: root
    width: 500
    height: 450
    visible: true
    title: qsTr("Tic Tac Toe")
    color: Theme.backgroundColor

    Row{
        id: topPanel
        width: parent.width
        height: root.height / 10

        Text {
            id: userWinText
            property int winCount: 0
            width: parent.width / 2
            text: qsTr("User : " + winCount)
            color: Theme.textColor
            horizontalAlignment : Text.AlignHCenter
            font.pixelSize: parent.height * 2 /3
        }
        Text {
            id: aiWinText
            property int winCount: 0
            width: parent.width / 2
            text: qsTr("AI : " + winCount)
            color: Theme.textColor
            horizontalAlignment : Text.AlignHCenter
            font.pixelSize: parent.height * 2 /3
        }
    }
    TicTacToe{
        id: ticTacToe
        anchors{
            fill: parent
            margins: Theme.itemSpacing
            topMargin: topPanel.height + Theme.itemSpacing
        }
        onGameOver: {
            switch(winner)
            {
            case Cell.Type.None : winnerText.text = qsTr("<<== The game was drawn ==>>")  ;break;
            case Cell.Type.Cross : winnerText.text = qsTr("<<== User Win ==>>") ; userWinText.winCount++ ;break;
            case Cell.Type.Circle : winnerText.text = qsTr("<<== AI Win ==>>") ;aiWinText.winCount++ ;break;
            }
            winnerText.text = winnerText.text + "\nClick To New Game"
        }
        onGameRestarted: winnerText.text = ""

        Rectangle{
            id: gameOverBanner
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.6);
            opacity: winnerText.text === "" ? 0.0 : 1.0
            visible: opacity > 0.0
            Behavior on opacity{PropertyAnimation{}}

            Rectangle{
                color: Theme.backgroundColor
                width: root.width + border.width * 2
                height: winnerText.height * 1.5
                border.width: 2
                border.color: Theme.borderColor
                anchors.centerIn: parent

                Text {
                    id: winnerText
                    anchors.centerIn: parent
                    color: Theme.textColor
                    font.pixelSize: root.height / 20
                    horizontalAlignment : Text.AlignHCenter
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: ticTacToe.restartGame()
                }
            }
        }
    }
}
