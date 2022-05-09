import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import com.pjhubs.asset 1.0


Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

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

    //TODO: 这种方式是为什么呢？
//    required property VideoAssetModel videoModel: VideoAssetModel{}

    VideoAssetModel {
        id: videoModel
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

        DropArea {
            anchors.fill: parent
            onDropped: (drop) => {
                           for (var i = 0; i < drop.urls.length; i++) {
                               videoModel.addVideo(drop.urls[i]);
                           }
                       }
        }
    }
}
