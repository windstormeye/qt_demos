import QtQuick 2.0
import "Item"

Rectangle {
    id: root
    color: "black"

    RightSliderItem {
        id: item_0
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
        tipTitle: "亮度"
        sliderType: RightSliderItem.SliderType.Middle
    }

    RightSliderItem {
        id: item_1
        height: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: item_0.bottom
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 10
        radius: 5
        tipTitle: "阴影"
        sliderType: RightSliderItem.SliderType.Left
    }
}
