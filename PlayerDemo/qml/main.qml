import QtQuick
//import "./qml"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("VideoEditorPlayer")
    color: "black"


    Row {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Player {
            id: player
            width: parent.width * 0.7
            height: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }

        Gallery {
            id: gallery
            width: parent.width * 0.3 - 10
            height: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            onSelectedVideo:(videoUrl) => {
                player.playWithVideoUrl(videoUrl)
            }
        }
    }
}
