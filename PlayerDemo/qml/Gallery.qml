import QtQuick 2.0
import com.pjhubs.asset 1.0


Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)
    radius: 5

//    ListModel {
//        id: contactModel
//        ListElement {
//            name: "Jim Williams"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "John Brown"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "PJHubs"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "YiYiMay"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//        ListElement {
//            name: "233333333333"
//            portrait: "../../img/image/pic.png"
//        }
//    }

    Component {
        id: cell
        Column {
            spacing: 5
            width: listView.cellWidth - listView.marginValue
                Rectangle {
                    id: coverContainer
                    radius: 10
                    width: parent.width
                    height: 50
                    Image {
                        id: coverImg
                        anchors.fill: parent
                        source: coverImage
                    }
                }
                Text {
                    id: coverTitle
                    width: coverContainer.width
                    height: 10
                    color: "white"
                    text: name
                    elide: Text.ElideRight
                }
        }
    }

    required property VideoAssetModel videoModel: VideoAssetModel{}

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

        Component.onCompleted: model.loadAssets()

        DropArea {
            anchors.fill: parent
            onDropped: (drop) => {
                           for(var i = 0; i<drop.urls.length; i++) {
                               console.log(drop.urls[i]);
                           }
                       }
        }
    }
}
