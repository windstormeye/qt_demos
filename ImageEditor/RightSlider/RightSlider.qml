import QtQuick 2.0
import "Item"

Rectangle {
    id: root
    color: Qt.rgba(50/255, 50/255, 50/255, 1)

    RightSliderItem {
        id: item_0
        height: 60
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
    }

    RightSliderItem {
        id: item_1
        height: 60
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: item_0.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
        color: "red"
    }

    RightSliderItem {
        id: item_2
        height: 60
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: item_1.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
        color: "blue"
    }

    RightSliderItem {
        id: item_3
        height: 60
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: item_2.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
        color: "green"
    }
}
