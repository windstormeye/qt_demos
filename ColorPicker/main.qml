import QtQuick
import Qt5Compat.GraphicalEffects

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Color Picker")

    Rectangle {
        // 色板
        property int rColor: maxColorValue
        property int gColor: 0
        property int bColor: 0
        property int maxColorValue: 255.0
        property real previousScale: 0

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

                    var mainColorProgress = (pickColorItem.x + pickColorItem.width / 2 - colorPicker.x) / colorPicker.width
                    var darkColorProgress = (pickColorItem.y + pickColorItem.height / 2 - colorPicker.y) / colorPicker.height

                    mainColorProgress = Math.min(mainColorProgress, 1)
                    mainColorProgress = Math.max(mainColorProgress, 0)

                    darkColorProgress = Math.min(darkColorProgress, 1)
                    darkColorProgress = Math.max(darkColorProgress, 0)

                    // 距白值
                    let offsetWR = (1 - colorSliderItem.color.r) * (1 - mainColorProgress)
                    let offsetWG = (1 - colorSliderItem.color.g) * (1 - mainColorProgress)
                    let offsetWB = (1 - colorSliderItem.color.b) * (1 - mainColorProgress)
                    // 距黑值
                    let offsetBR = colorSliderItem.color.r * darkColorProgress
                    let offsetBG = colorSliderItem.color.g * darkColorProgress
                    let offsetBB = colorSliderItem.color.b * darkColorProgress

                    let adjustR = colorSliderItem.color.r - offsetBR + offsetWR * (1 - darkColorProgress)
                    let adjustG = colorSliderItem.color.g - offsetBG + offsetWG * (1 - darkColorProgress)
                    let adjustB = colorSliderItem.color.b - offsetBB + offsetWB * (1 - darkColorProgress)

                    pickColorItem.color = Qt.rgba(adjustR, adjustG, adjustB)
                }
            }
            onReleased: {
                isTouchMouse = false
                colorPicker.maxColorValue = 255.0
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
                hexColor(inputString)
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
                let r = currentValue
                let g = Math.floor(pickColorItem.color.g * 255.0)
                let b = Math.floor(pickColorItem.color.b * 255.0)
                // 拿出当前最大色值
                let maxColorValue = Math.max(Math.max(r, g), b)
                // 算出与 255 偏移量
                let offsetColorValue = 255 - maxColorValue
                // 值填充至 255
                let adjustR = r + offsetColorValue
                let adjustG = g + offsetColorValue
                let adjustB = b + offsetColorValue
                // 找出属于的主色区
                let isFullR = (adjustR === 255)
                let isFullG = (adjustG === 255)
                let isFullB = (adjustB === 255)

                console.log(isFullR + ", " + isFullG + ", " + isFullB)
                let colorItemWidth = 1/6.0
                if (isFullR && !isFullG && !isFullB) {
                    // 算出 progress
                    let progress = pickColorItem.color.g * colorItemWidth
                    colorSliderItem.x = colorSlider.width + colorSlider.x + progress * colorSlider.width
                } else if (isFullR && isFullG && !isFullB) {

                } else if (!isFullR && isFullG && !isFullB) {

                } else if (!isFullR && isFullG && isFullB) {

                } else if (!isFullR && !isFullG && isFullB) {

                } else if (isFullR && !isFullG && isFullB) {

                } else if (isFullR && !isFullG && !isFullB) {

                }


                pickColorItemMouse.isOtherTouchMouse = true
                colorPicker.maxColorValue = Math.max(Math.max(currentValue, g), b)
                console.log(colorPicker.maxColorValue)
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
                let r = Math.floor(pickColorItem.color.r * 255.0)
                let g = currentValue
                let b = Math.floor(pickColorItem.color.b * 255.0)
                // 拿出当前最小色值
                let maxColorValue = Math.min(Math.min(r, g), b)
                // 算出与 255 偏移量
                let offsetColorValue = 255 - maxColorValue
                // 值填充至 255
                let adjustR = r + offsetColorValue
                let adjustG = g + offsetColorValue
                let adjustB = b + offsetColorValue
                // 找出属于的主色区
                let isFullR = (adjustR > 255)
                let isFullG = (adjustG > 255)
                let isFullB = (adjustB > 255)

                console.log(isFullR + ", " + isFullG + ", " + isFullB)
                let colorItemWidth = 1/7.0
                if (isFullR && !isFullG && !isFullB) {
                    // 算出 progress

                } else if (isFullR && isFullG && !isFullB) {
                    console.log(g)
                    let progress = g / 255.0 * colorItemWidth
                    colorSliderItem.x = colorSlider.x + progress * colorSlider.width
                } else if (!isFullR && isFullG && !isFullB) {

                } else if (!isFullR && isFullG && isFullB) {

                } else if (!isFullR && !isFullG && isFullB) {

                } else if (isFullR && !isFullG && isFullB) {

                } else if (isFullR && !isFullG && !isFullB) {

                }

                colorSliderMouse.positionChanged(0)
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
                let currentValue = parseInt(bInput.text)
                if (currentValue > colorPicker.maxColorValue) {
                    colorPicker.maxColorValue = currentValue
                    pickColorItemMouse.isOtherTouchMouse = true





                    pickColorItemMouse.isOtherTouchMouse = false
                    console.log(colorPicker.maxColorValue)
                }
            }
        }
    }

    Rectangle {
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
                let colorItemWidth = 1/6.0

                if (progress >= 0 && progress <= 1/6.0) {
                    let adjustProgress = progress / colorItemWidth
                    colorSliderItem.color = Qt.rgba(1, adjustProgress, 0, 1)
                } else if (progress > colorItemWidth && progress <= colorItemWidth * 2) {
                    let adjustProgress = (progress - colorItemWidth) / colorItemWidth
                    colorSliderItem.color = Qt.rgba(1 - adjustProgress, 1, 0, 1)
                } else if (progress > colorItemWidth * 2 && progress <= colorItemWidth * 3) {
                    let adjustProgress = (progress - colorItemWidth * 2) / colorItemWidth
                    colorSliderItem.color = Qt.rgba(0, 1, adjustProgress, 1)
                } else if (progress > colorItemWidth * 3 && progress <= colorItemWidth * 4) {
                    let adjustProgress = (progress - colorItemWidth * 3) / colorItemWidth
                    colorSliderItem.color = Qt.rgba(0, 1 - adjustProgress, 1, 1)
                } else if (progress > colorItemWidth * 4 && progress <= colorItemWidth * 5) {
                    let adjustProgress = (progress - colorItemWidth * 4) / colorItemWidth
                    colorSliderItem.color = Qt.rgba(adjustProgress, 0, 1, 1)
                } else if (progress > colorItemWidth * 5 && progress <= colorItemWidth * 6) {
                    let adjustProgress = (progress - colorItemWidth * 5) / colorItemWidth
                    colorSliderItem.color = Qt.rgba(1, 0, 1 - adjustProgress, 1)
                }
                colorPicker.rColor = colorSliderItem.color.r * 255.0
                colorPicker.gColor = colorSliderItem.color.g * 255.0
                colorPicker.bColor = colorSliderItem.color.b * 255.0

                pickColorItemMouse.positionChanged(0)
            }
            onReleased: {
                isTouchMouse = false
                pickColorItemMouse.isOtherTouchMouse = false
            }
        }
    }
}
