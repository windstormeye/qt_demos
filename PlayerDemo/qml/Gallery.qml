import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import com.pjhubs.asset 1.0


Rectangle {

    signal selectedVideo(string videoUrl)

    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

    VideoAssetModel {
        id: videoModel
    }

    Component {
        id: cell

        Column {
            spacing: 5
            width: listView.cellWidth - listView.marginValue

            Image {
                id: coverImg
                height: 50
                width: parent.width
                source: asset.coverImage
                visible: false
            }

            Rectangle {
                id: coverContainer
                width: coverImg.width
                height: 50
                radius: 5
                visible: false
            }

            OpacityMask {
                id: mask
                width: parent.width
                height: coverImg.height
                source: coverImg
                maskSource: coverContainer

                MouseArea {
                    width: listView.cellWidth
                    height: listView.cellHeight
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (mouse) => {
                                   if (mouse.button === Qt.LeftButton) {
                                       selectedVideo(asset.url)
                                   }
                                   if (mouse.button === Qt.RightButton) {
                                       var adjustX = 0
                                       var adjustY = 0
                                       if (index % 2) {
                                           // 第二列
                                           adjustX = index % 2 * listView.cellWidth
                                       }
                                       if (index / 2) {
                                           adjustY = index / 2 * listView.cellHeight

                                           if (index % 2) {
                                               // 第二列
                                               adjustY = (index - 1) / 2 * listView.cellHeight
                                           }
                                       }

                                       mouseMenu.x = adjustX + mouseX
                                       mouseMenu.y = adjustY + mouseY - listView.contentY
                                       mouseMenu.visible = true
                                       mouseMenu.cellIndex = index
                                   }
                               }
                }
            }


            Text {
                id: coverTitle
                width: coverImg.width
                height: 10
                color: "white"
                text: asset.name
                elide: Text.ElideRight
            }
        }
    }

    GridView {
        id: listView
        property var marginValue: 10

        anchors.fill: parent
        cellWidth: parent.width / 2 - marginValue / 2
        cellHeight: 80
        anchors.topMargin: marginValue
        anchors.bottomMargin: marginValue
        anchors.leftMargin: marginValue

        model: videoModel
        delegate: cell

        Component.onCompleted: {
            videoModel.loadAssets()
        }
        onContentYChanged: {
            mouseMenu.visible = false
        }

        DropArea {
            anchors.fill: parent
            onDropped: (drop) => {
                           var videoUrls = ""
                           for (var i = 0; i < drop.urls.length; i++) {
                               videoUrls += drop.urls[i]

                               if (i != drop.urls.length - 1) {
                                   videoUrls += ","
                               }
                           }
                           videoModel.addVideos(videoUrls)
                       }
        }

        Rectangle {
            property int cellIndex: 0

            id: mouseMenu
            width: 80
            height: 60
            radius: 5
            color: Qt.rgba(40/255, 40/255, 40/255, 1)
            visible: false

            Text {
                id: deleteItem
                text: qsTr("删除")
                color: "white"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 10
                anchors.top: parent.top

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        videoModel.removeVideo(mouseMenu.cellIndex)
                        mouseMenu.visible = false
                    }
                }
            }

            Text {
                id: copyItem
                text: qsTr("复制")
                color: "white"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.topMargin: 10
                anchors.top: deleteItem.bottom

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        videoModel.addVideos(videoModel.urlAt(mouseMenu.cellIndex))
                        mouseMenu.visible = false
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onExited: {
                    mouseMenu.visible = false
                }
            }
        }
    }
}
