import QtQuick 2.0

Rectangle {
    color: "black"
    opacity: 0.8
    anchors.fill: parent

    Text {
        id: titleText
        text: "将文件拖放至此打开"
        color: "white"
        font.pixelSize: 30
        anchors.centerIn: parent
    }

    Text {
        id: subtitleText
        text: "目前暂仅支持 .jpg、.jpeg、.png 格式的图片"
        color: "white"
        font.pixelSize: 15
        anchors.top: titleText.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
