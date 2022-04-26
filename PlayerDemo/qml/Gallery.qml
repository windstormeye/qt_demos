import QtQuick 2.0

Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)

    ListModel {
        id: contactModel
        ListElement {
            name: "Jim Williams"
            portrait: "../../img/image/pic.png"
        }
        ListElement {
            name: "John Brown"
            portrait: "../../img/image/pic.png"
        }
        ListElement {
            name: "PJHubs"
            portrait: "../../img/image/pic.png"
        }
    }
    GridView {
        width: parent.width
        height: parent.heigh
        cellWidth: 60
        cellHeight: 50
        model: contactModel
        delegate: Column {
            Image {
                width: 50
                height: 50
                source: portrait
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                width: 50
                color: "white"
                text: name
                elide: Text.ElideRight
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
