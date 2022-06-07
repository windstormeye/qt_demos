import QtQuick 2.12

Rectangle {
    enum SliderType {
        Middle,
        Left
    }
    property string tipTitle: ""
    property int sliderType: RightSliderItem.SliderType.Left


    QtObject {
        id: internal
        property bool isPressed: false
        property int sliderValue: 0
        property string valueText: "0"
    }

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
        x: (sliderType === RightSliderItem.SliderType.Middle) ? (parent.width - 2) / 2 : 0
    }

    Rectangle {
        id: highlightRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.rgba(1, 1, 1, 0.05)
    }

    Text {
        id: sliderValueText
        text: internal.valueText
        color: "white"
        font.pixelSize: 15
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: Qt.rgba(30/255, 30/255, 30/255, 1) }
        GradientStop { position: 1.0; color: Qt.rgba(100/255, 100/255, 100/255, 1) }
     }

    MouseArea {
        id: clickMouse
        anchors.fill: parent
        onClicked: {
            sliderChange(mouseX)
        }
        onPressed: {
            internal.isPressed = true
        }
        onReleased: {
            internal.isPressed = false
        }
        onPositionChanged: {
            if (mouseX < 0) {
                return
            }
            if (mouseX > parent.width) {
                return
            }

            if (internal.isPressed) {
                sliderChange(mouseX)
            }
        }
    }

    function sliderChange(mouseX) {
        splitLine.x = mouseX - 1
        var sliderValue = 0
        if (sliderType === RightSliderItem.SliderType.Middle) {
            if (mouseX >= parent.width / 2) {
                var adjustMouseX = (mouseX - parent.width / 2) * 2
                highlightRect.x = parent.width / 2
                highlightRect.width = mouseX - parent.width / 2
                sliderValue = (adjustMouseX / parent.width)
                formatterSliderValue(sliderValue)
                internal.valueText = internal.sliderValue
            } else {
                highlightRect.x = mouseX
                highlightRect.width = parent.width / 2 - mouseX
                sliderValue = 1 - (mouseX / parent.width) * 2
                formatterSliderValue(sliderValue)
                internal.valueText = qsTr("-" + internal.sliderValue)
            }
        } else if (sliderType === RightSliderItem.SliderType.Left) {
            highlightRect.x = 0
            highlightRect.width = mouseX

            sliderValue = mouseX / parent.width
            formatterSliderValue(sliderValue)
            internal.valueText = internal.sliderValue
        }
    }

    function formatterSliderValue(sliderValue) {
        console.log(sliderValue)
        if (sliderValue < 0.01) {
           sliderValue = 0
        } else if (sliderValue > 0.94) {
            sliderValue = 1
        }
        internal.sliderValue = sliderValue * 100
    }
}
