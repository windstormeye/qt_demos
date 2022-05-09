import QtQuick 2.0

Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

    ControlBar {
        id: controlBar
        width: parent.width * 0.9
        height: 70
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }
}
