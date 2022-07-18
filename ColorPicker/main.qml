import QtQuick
import Qt5Compat.GraphicalEffects

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Color Picker")

    Rectangle {
        // 色板
        property int rColor: 255.0
        property int gColor: 0
        property int bColor: 0
        property int maxColorValue: 255.0
        property real previousScale: 0
        property real mainHue: 0

        id: colorPicker
        width: 262
        height: width
        x: 10
        y: 10
        radius: 4

        Component.onCompleted: {
            pickColorItemMouse.positionChanged(0)
        }

        LinearGradient {
            // 主色渐变
            width: parent.width
            height: parent.width
            start: Qt.point(0, 0)
            end: Qt.point(parent.width, 0)
            source: colorPicker
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#FFFFFF"
                }
                GradientStop {
                    id: mainColorGradient
                    position: 1.0
                    color: colorSliderItem.color
                }
            }
        }

        LinearGradient {
            // 黑白渐变
            width: parent.width
            height: parent.width
            start: Qt.point(0, 0)
            end: Qt.point(0, parent.width)
            source: colorPicker
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#00000000"
                }
                GradientStop {
                    id: darkColorGradient
                    position: 1.0
                    color: "#FF000000"
                }
            }
        }
    }

    Rectangle {
        // 色板取色item
        id: pickColorItem
        width: 14
        height: width
        radius: width / 2
        x: colorPicker.x + colorPicker.width - width / 2
        y: colorPicker.y - height / 2
        color: "red"
        border.color: "white"
        border.width: 2
        antialiasing: true
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
        }

        MouseArea {
            property bool isTouchMouse: false
            property bool isOtherTouchMouse: false

            id: pickColorItemMouse
            anchors.fill: parent
            onPressed: {
                isTouchMouse = true
            }
            onPositionChanged: {
                if (isTouchMouse || isOtherTouchMouse) {
                    if (isTouchMouse) {
                        let adjustPos = mapToItem(colorPicker, mouseX, mouseY)
                        pickColorItem.x = adjustPos.x
                        pickColorItem.y = adjustPos.y
                        // 边界限制
                        if (pickColorItem.y + pickColorItem.width / 2 > colorPicker.height + colorPicker.y) {
                            pickColorItem.y = colorPicker.y + colorPicker.height - pickColorItem.width / 2
                        }
                        if (pickColorItem.y < -pickColorItem.width / 2 + colorPicker.x) {
                            pickColorItem.y = -pickColorItem.width / 2 + colorPicker.x
                        }
                        if (pickColorItem.x < -pickColorItem.width / 2 + colorPicker.x) {
                            pickColorItem.x = -pickColorItem.width / 2 + colorPicker.x
                        }
                        if (pickColorItem.x + pickColorItem.width / 2 > colorPicker.width + colorPicker.y) {
                            pickColorItem.x = colorPicker.width + colorPicker.x - pickColorItem.width / 2
                        }
                    }

                    // 饱和度限制
                    var saturaionValue = (pickColorItem.x + pickColorItem.width / 2 - colorPicker.x) / colorPicker.width
                    // 亮度限制
                    var lightness = (pickColorItem.y + pickColorItem.height / 2 - colorPicker.y) / colorPicker.height

                    saturaionValue = Math.min(saturaionValue, 1)
                    saturaionValue = Math.max(saturaionValue, 0)

                    lightness = Math.min(lightness, 1)
                    lightness = Math.max(lightness, 0)

                    let s = saturaionValue
                    let l = (1 - lightness)
                    highlightColor.color = Qt.hsva(colorPicker.mainHue, s, l)
                    pickColorItem.color = highlightColor.color

                    updateHexColorString()
                }
            }
            onReleased: {
                isTouchMouse = false
                colorPicker.maxColorValue = Math.max(Math.max(pickColorItem.color.r, pickColorItem.color.g), pickColorItem.color.b) * 255.0
            }
        }
    }

    Rectangle {
        id: highlightColor
        color: pickColorItem.color
        width: 200
        height: 50
        anchors.left: colorPicker.right
        anchors.top: colorPicker.top
        anchors.leftMargin: 50
    }

    Rectangle {
        property string defualtText: "ffff00"
        property string rexExp: "/^[A-Za-z0-9]{6}$/"
        property var rexExpValidator: /^[A-Za-z0-9]{6}$/

        signal hexColor(string hexString);


        id: hexColortextInputRoot
        width: 101
        height: 32
        anchors.top: highlightColor.bottom
        anchors.topMargin: 20
        anchors.left: highlightColor.left
        color: "#505057"

        TextInput {
            id: hexColortextInput
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            verticalAlignment: TextInput.AlignVCenter
            color: "white"
            text: hexColortextInputRoot.defualtText
            font.capitalization: Font.AllUppercase
            clip: true
            selectByMouse: true
            validator: RegularExpressionValidator { regularExpression: hexColortextInputRoot.rexExpValidator }

            onEditingFinished: {
                let inputString = hexColortextInput.text

                let rHex = inputString.substr(0, 2)
                let gHex = inputString.substr(2, 2)
                let bHex = inputString.substr(4, 2)

                let r = parseInt(rHex, 16) / 255.0
                let g = parseInt(gHex, 16) / 255.0
                let b = parseInt(bHex, 16) / 255.0

                updateColorWithRGB(r, g, b)
            }
        }
    }

    Rectangle {
        // R 通道输入
        id: rInputRoot
        anchors.left: hexColortextInputRoot.left
        anchors.top: hexColortextInputRoot.bottom
        anchors.topMargin: 20
        height: hexColortextInputRoot.height
        width: 40
        color: hexColortextInputRoot.color

        TextInput {
            id: rInput
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            verticalAlignment: TextInput.AlignVCenter
            color: "white"
            text: Math.floor(pickColorItem.color.r * 255.0)
            clip: true
            selectByMouse: true
            validator: RegularExpressionValidator { regularExpression: /[0-9]{1,3}/ }

            onEditingFinished: {
                let currentValue = parseInt(rInput.text)
                updateColorWithRGB(currentValue, pickColorItem.color.g, pickColorItem.color.b)
            }
        }
    }

    Rectangle {
        // G 通道输入
        id: gInputRoot
        anchors.left: rInputRoot.right
        anchors.top: rInputRoot.top
        anchors.leftMargin: 5
        height: rInputRoot.height
        width: 40
        color: rInputRoot.color

        TextInput {
            id: gInput
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            verticalAlignment: TextInput.AlignVCenter
            color: "white"
            text: Math.floor(pickColorItem.color.g * 255.0)
            clip: true
            selectByMouse: true
            validator: RegularExpressionValidator { regularExpression: /[0-9A-F]{1,3}+/ }

            onEditingFinished: {
                let currentValue = parseInt(gInput.text)
                updateColorWithRGB(pickColorItem.color.r, currentValue, pickColorItem.color.b)
            }
        }
    }

    Rectangle {
        // B 通道输入
        id: bInputRoot
        anchors.left: gInputRoot.right
        anchors.top: gInputRoot.top
        anchors.leftMargin: 5
        height: gInputRoot.height
        width: 40
        color: gInputRoot.color

        TextInput {
            id: bInput
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            verticalAlignment: TextInput.AlignVCenter
            color: "white"
            text: Math.floor(pickColorItem.color.b * 255.0)
            clip: true
            selectByMouse: true
            validator: RegularExpressionValidator { regularExpression: /[0-9A-F]{1,3}+/ }

            onEditingFinished: {
                let currentValue = parseInt(bInput.text) / 255.0
                updateColorWithRGB(pickColorItem.color.r, pickColorItem.color.g, currentValue)
            }
        }
    }

    Rectangle {
        property real colorItemWidth: 1/7.0

        id: colorSlider
        width: 200
        height: 14
        anchors.top: colorPicker.bottom
        anchors.topMargin: 20
        anchors.right: colorPicker.right
        radius: height / 2

        LinearGradient {
            // 主色渐变
            id: colorSliderGradient
            width: parent.width
            height: parent.height
            start: Qt.point(0, 0)
            end: Qt.point(parent.width, 0)
            source: colorSlider
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: Qt.rgba(1, 0, 0, 1)
                }
                GradientStop {
                    position: 1/6.0
                    color: Qt.rgba(1, 1, 0, 1)
                }
                GradientStop {
                    position: 1/6.0 * 2
                    color: Qt.rgba(0, 1, 0, 1)
                }
                GradientStop {
                    position: 1/6.0 * 3
                    color: Qt.rgba(0, 1, 1, 1)
                }
                GradientStop {
                    position: 1/6.0 * 4
                    color: Qt.rgba(0, 0, 10, 1)
                }
                GradientStop {
                    position: 1/6.0 * 5
                    color: Qt.rgba(1, 0, 1, 1)
                }
                GradientStop {
                    position: 1.0
                    color: Qt.rgba(1, 0, 0, 1)
                }
            }
        }
    }

    Rectangle {
        id: colorSliderItem
        width: colorSlider.height
        height: width
        radius: height / 2
        color: "#FF0000"
        border.color: "white"
        border.width: 2
        layer.enabled: true
        x: colorSlider.x
        y: colorSlider.y
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
        }

        MouseArea {
            property bool isTouchMouse: false
            property bool isOtherTouchMouse: false

            id: colorSliderMouse
            anchors.fill: parent
            onPressed: {
                isTouchMouse = true
                pickColorItemMouse.isOtherTouchMouse = true
            }
            onPositionChanged: {
              if (isTouchMouse) {
                  let adjustPos = mapToItem(colorSlider, mouseX, mouseY)
                  var adjustX = adjustPos.x - width / 2
                  adjustX = Math.min(adjustX, colorSlider.width - width)
                  adjustX = Math.max(adjustX, 0)
                  colorSliderItem.x = adjustX + colorSlider.x
              }

              // 色杆进度
              var progress = (colorSliderItem.x - colorSlider.x) / (colorSlider.width - colorSliderItem.width)

              colorPicker.mainHue = progress
              pickColorItemMouse.positionChanged(0)

              colorSliderItem.color = Qt.hsva(progress, 1, 1)
              updateHexColorString()

              colorPicker.rColor = colorSliderItem.color.r * 255.0
              colorPicker.gColor = colorSliderItem.color.g * 255.0
              colorPicker.bColor = colorSliderItem.color.b * 255.0
            }
            onReleased: {
                isTouchMouse = false
                pickColorItemMouse.isOtherTouchMouse = false
            }
        }
    }

    function updateColorItemsPosition() {
        let h = highlightColor.color.hsvHue
        let s = highlightColor.color.hsvSaturation
        let v = highlightColor.color.hsvValue

        let x = colorPicker.x
        let y = colorPicker.y

        pickColorItem.x = x + colorPicker.width * s - pickColorItem.width / 2
        pickColorItem.y = y + colorPicker.height * (1 - v) - pickColorItem.height / 2

        // 输入 0,0,0 || 255,255,255
        if (highlightColor.color === Qt.color("white") ||
                highlightColor.color === Qt.color("black") ||
                equalHighlightColor()) {
            return
        }
        colorSliderItem.x = h * colorSlider.width + colorSlider.x
    }

    function equalHighlightColor() {
        if (highlightColor.color.r - highlightColor.color.g < 0.001 &&
                highlightColor.color.r - highlightColor.color.b < 0.001 &&
                highlightColor.color.b - highlightColor.color.g < 0.001) {
            return true
        }
        return false
    }

    function updateHexColorString() {
        let r = Math.floor(highlightColor.color.r * 255)
        let g = Math.floor(highlightColor.color.g * 255)
        let b = Math.floor(highlightColor.color.b * 255)

        var rHex = (r).toString(16)
        if (r < 16) {
            rHex = "0" + rHex
        }

        var gHex = (g).toString(16)
        if (g < 16) {
            gHex = "0" + gHex
        }

        var bHex = (b).toString(16)
        if (b < 16) {
            bHex = "0" + bHex
        }

        hexColortextInput.text = rHex + gHex + bHex
    }

    function updateColorWithRGB(r, g, b) {
        highlightColor.color = Qt.rgba(r, g, b)
        pickColorItem.color = highlightColor.color

        colorPicker.mainHue = pickColorItem.color.hslHue
        if (!equalHighlightColor()) {
            colorSliderItem.color = Qt.hsva(highlightColor.color.hsvHue, 1, 1)
        }

        updateColorItemsPosition()
        updateHexColorString()
    }
}
