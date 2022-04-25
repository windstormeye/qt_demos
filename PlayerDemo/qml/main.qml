import QtQuick
//import "./qml"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("VideoEditorPlayer")

    Row {
        anchors.fill: parent
        spacing: 0

        Player {
            id: player
            width: parent.width * 0.7
            height: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }

        Gallery {
            id: gallery
            width: parent.width * 0.3
            height: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }
}
