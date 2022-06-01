import QtQuick 2.0
import QtMultimedia

Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

    Video {
        id: video
        anchors.fill: parent
        source: ""

        onPositionChanged: {
            controlBar.currentTime = video.position
            controlBar.changeProgressValue(video.position / video.duration)
        }

        onDurationChanged: {
            controlBar.totalTime = video.duration
        }

        onPlaybackStateChanged: {
            if (video.playbackState === MediaPlayer.StoppedState) {
                controlBar.visible = false
                video.play()
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPositionChanged: {
                if (video.playbackState === MediaPlayer.PlayingState) {
                    controlBar.visible = true
                    // NOTE: infinite play video
                    controlBarTimer.start()
                }
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
        visible: false
        onPlayButtonClicked: {
            if (video.source === "") {
                return
            }
            if (controlBar.isPlay) {
                video.play()
            } else {
                video.pause()
            }
        }
        onPreButtonClicked: {
            video.position -= 3000
            controlBarTimer.stop()
        }
        onNextButtonClicked: {
            video.position += 3000
            controlBarTimer.stop()
        }
    }

    Timer {
        id: controlBarTimer
        interval: 4000
        repeat: false
        running: false
        onTriggered: {
            controlBar.visible = false
        }
    }

    function playWithVideoUrl(videoUrl) {
        video.source = videoUrl
        video.play()
        if (controlBar.isPlay === false) {
            controlBar.changePlayrState()
        }

        // NOTE: 切换视频时 controlBar 可展示
        controlBar.visible = true
        controlBarTimer.start()
    }
}
