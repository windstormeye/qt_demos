import QtQuick 2.12

Rectangle {
    property string tipTitle: ""

    id: root

    Text {
        text: root.tipTitle
        color: "white"
        font.pixelSize: parent.height / 3
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: splitLine
        width: 2
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.rgba(1, 1, 1, 0.3)
        x: (parent.width - 2) / 2
    }

    Rectangle {
        id: highlightRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.rgba(1, 1, 1, 0.2)
    }

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: Qt.rgba(30/255, 30/255, 30/255, 1) }
        GradientStop { position: 1.0; color: Qt.rgba(100/255, 100/255, 100/255, 1) }
     }

    MouseArea {
        id: clickMouse
        anchors.fill: parent
        onClicked:(mouse) => {
                      splitLine.x = mouseX - 1
                      if (mouseX >= parent.width / 2) {
                          highlightRect.x = parent.width / 2
                          highlightRect.width = mouseX - parent.width / 2
                      } else {
                          highlightRect.x = mouseX
                          highlightRect.width = parent.width / 2 - mouseX
                      }
        }
    }
}
