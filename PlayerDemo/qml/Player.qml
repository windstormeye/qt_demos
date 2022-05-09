import QtQuick 2.0
import QtMultimedia 5.15


Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

    Video {
        id: video
        anchors.fill: parent
        source: "file:///Users/bytedance/Desktop/qt_demo_素材/Sea\ -\ 7741.mp4"
        focus: true
        MouseArea {
             anchors.fill: parent
             onClicked: {
                 video.play()
             }
         }
    }

    ControlBar {
        id: controlBar
        width: parent.width * 0.9
        height: 70
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        onPlayButtonClicked: {
            if (controlBar.isPlay) {
                video.play()
            } else {
                video.pause()
            }
        }
    }
}
