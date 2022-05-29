import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    signal clicked;
    id: root
    anchors.fill: parent
    color: "black"


    Rectangle {
        width: 80
        height: 30
        radius: 20
        color: Qt.rgba(30/255, 30/255, 30/255, 1)
        anchors.centerIn: parent

        Text {
            text: "选择素材"
            color: "white"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
