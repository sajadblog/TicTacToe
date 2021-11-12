import QtQuick 2.15

Rectangle {
    id: root
    signal clicked()
    enum Type {
            None = 0,
            Cross,
            Circle
        }
    property int type: Cell.Type.None
    QtObject{
        id: internal
        property int selectHeight: (((root.width < root.height) ? root.width : root.height) - Theme.itemSpacing * 4)
        property int selectWidth: selectHeight / 10
    }

    border.width: 1
    border.color: Theme.borderColor
    radius: width / 10
    Behavior on color {PropertyAnimation{}}
    MouseArea{
        anchors.fill: parent
        enabled: root.type === Cell.Type.None
        onClicked: root.clicked()
    }
    Rectangle{
        height: internal.selectHeight
        width: internal.selectWidth
        visible: opacity > 0
        opacity: root.type === Cell.Type.Cross ? 1.0 : 0.0
        anchors.centerIn: parent
        rotation: 45
        Behavior on opacity {PropertyAnimation{}}
    }
    Rectangle{
        height: internal.selectHeight
        width: internal.selectWidth
        visible: opacity > 0
        opacity: root.type === Cell.Type.Cross ? 1.0 : 0.0
        anchors.centerIn: parent
        rotation: -45
        Behavior on opacity {PropertyAnimation{}}
    }
    Rectangle{
        height: internal.selectHeight
        width: height
        radius: height / 2
        visible: opacity > 0
        border.width: internal.selectWidth
        border.color: Theme.textColor
        color: "transparent"
        opacity: root.type === Cell.Type.Circle ? 1.0 : 0.0
        anchors.centerIn: parent
        Behavior on opacity {PropertyAnimation{}}
    }
}
