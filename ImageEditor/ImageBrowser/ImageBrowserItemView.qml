import QtQuick 2.0

Rectangle {
    signal selected(var selectedBox)

    property string coverUrl: ""
    property bool isSelected: false

    id: root
    anchors.fill: parent
    color: "black"

    Image {
        id: coverImage
        source: coverUrl
        width: parent.width - 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: selectedBox
        anchors.fill: parent
        border.color: "white"
        border.width: 1.5
        radius: 1
        color: "transparent"
        visible: isSelected
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            isSelected = true
            root.selected(selectedBox)
        }
    }
}
