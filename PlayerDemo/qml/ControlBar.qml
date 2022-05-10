import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt5Compat.GraphicalEffects

Rectangle {
    signal playButtonClicked()

    /// 是否播放
    property bool isPlay: false
    /// 当前播放进度
    property double currentTime: 0
    property double totalTime: 0
    property double progressValue: 0

    function changePlayrState() {
        this.isPlay = !this.isPlay
        if (this.isPlay) {
            playButtonImg.source = "qrc:/img/image/player-pause.png"
        } else {
            playButtonImg.source = "qrc:/img/image/player-play.png"
        }
    }

    function changeProgressValue(progressValue) {
        progressBar.value = progressValue
    }

    function formatterTime(time) {
        let seconds = parseInt(time / 1000)
        let mins = parseInt(time / 1000 / 60)

        if (seconds < 10) {
            seconds = "0" + seconds
        }

        if (mins < 9) {
            mins = "0" + mins
        }

        return mins + ":" + seconds
    }

    id: root
    width: parent.width
    height: parent.height
    radius: 10
    color: Qt.rgba(40/255, 40/255, 40/255, 1)

    Column {
        width: parent.width
        height: parent.height
        spacing: 10

        Row {
            spacing: 40
            height: parent.height / 2
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: preButton
                width: 40
                height: 20
                color: Qt.rgba(100/255, 100/255, 100/255, 1)
                radius: 5
                anchors.top: parent.top
                anchors.topMargin: 10

                Image {
                    id: preButtonImg
                    anchors.fill: parent
                    anchors.margins: 1
                    source: "qrc:/img/image/player-track-prev.png"
                    fillMode: Image.PreserveAspectFit
                    ColorOverlay {
                        anchors.fill: preButtonImg
                        source: preButtonImg
                        color: "white"
                    }
                }
            }

            Rectangle {
                id: playButton
                width: 40
                height: 20
                color: Qt.rgba(100/255, 100/255, 100/255, 1)
                radius: 5
                anchors.top: parent.top
                anchors.topMargin: 10

                Image {
                    id: playButtonImg
                    anchors.fill: parent
                    anchors.margins: 1
                    source: "qrc:/img/image/player-play.png"
                    fillMode: Image.PreserveAspectFit
                    ColorOverlay {
                        anchors.fill: playButtonImg
                        source: playButtonImg
                        color: "white"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        changePlayrState()
                        root.playButtonClicked()
                    }
                }
            }

            Rectangle {
                id: nextButton
                width: 40
                height: 20
                color: Qt.rgba(100/255, 100/255, 100/255, 1)
                radius: 5
                anchors.top: parent.top
                anchors.topMargin: 10

                Image {
                    id: nextButtonImg
                    anchors.fill: parent
                    anchors.margins: 1
                    source: "qrc:/img/image/player-track-next.png"
                    fillMode: Image.PreserveAspectFit
                    ColorOverlay {
                        anchors.fill: nextButtonImg
                        source: nextButtonImg
                        color: "white"
                    }
                }
            }
        }

        Row {
            id: progreessBarContainer
            height: parent.height / 2
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            ProgressBar {
                id: progressBar
                value: progressValue
                width: root.width * 0.7
                height: 20
            }

            Label {
                text: formatterTime(currentTime) + "/" + formatterTime(totalTime)
                anchors.verticalCenter: progressBar.verticalCenter
            }
        }
    }
}
