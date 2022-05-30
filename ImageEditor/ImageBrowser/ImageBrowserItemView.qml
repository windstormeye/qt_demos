import QtQuick 2.0

Rectangle {
    property string coverUrl: ""

    anchors.fill: parent
    color: "black"

    Image {
        id: coverImage
        source: coverUrl
        width: parent.width - 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
