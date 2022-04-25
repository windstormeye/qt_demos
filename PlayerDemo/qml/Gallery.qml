import QtQuick 2.0

Rectangle {
    color: Qt.rgba(20/255, 20/255, 20/255, 1)

    ListModel {
        id: contactModel
        ListElement {
            name: "Jim Williams"
//            portrait: "pics/portrait.png"
        }
        ListElement {
            name: "John Brown"
//            portrait: "pics/portrait.png"
        }
        ListElement {
            name: "PJHubs"
//            portrait: "pics/portrait.png"
        }
    }
    GridView {
        width: parent.width
        height: parent.heigh
        cellWidth: parent.width / 2 - 10
        cellHeight: 30
        model: contactModel
        delegate: Column {
//            Image { source: portrait; anchors.horizontalCenter: parent.horizontalCenter }
            Text {
                color: "white"
                text: name;
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
