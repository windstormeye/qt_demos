import QtQuick

Window {
    width: 640
    height: 400
    visible: true
    title: qsTr("VideoEditorPlayer")
    color: "black"
    minimumWidth: 640
    minimumHeight: 400

    Player {
        id: player
        height: parent
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: gallery.left
        anchors.left: parent.left
        anchors.rightMargin: 10
        anchors.margins: 10
    }

    Gallery {
        id: gallery
        width: 175
        height: parent
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        onSelectedVideo:(videoUrl) => {
            player.playWithVideoUrl(videoUrl)
        }
    }
}
