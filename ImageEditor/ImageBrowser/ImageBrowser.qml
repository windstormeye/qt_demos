import QtQuick 2.0

Rectangle {
    color: "black"

    Rectangle {
        id: item0
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "gray"
    }

    Rectangle {
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: item0.right
        anchors.leftMargin: 10
        color: "gray"
    }
}
