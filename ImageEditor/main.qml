import QtQuick
import Qt.labs.platform 1.1

import "ImageShower"
import "ImageBrowser"
import "RightSlider"
import "DrapHighlight"
import "BlankView"

Window {
    width: 900
    height: 500
    visible: true
    title: qsTr("图片编辑器")
    color: "black"


    ImageShower {
        anchors.left: parent.left
        anchors.right: rightSlider.left
        anchors.top: parent.top
        anchors.bottom: imageBrowser.top
        anchors.margins: 10
        visible: imageBrowser.modelCounts > 0
        imageModel: imageBrowser.currentImageAsset
    }

    ImageBrowser {
        id: imageBrowser
        height: 50
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: rightSlider.left
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        visible: imageBrowser.modelCounts > 0
    }

    RightSlider {
        id: rightSlider
        width: 200
        height: parent.height - 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        visible: imageBrowser.modelCounts > 0
    }


    DrapHighLight {
        id: drapHighlight
        anchors.fill: parent
        visible: false
    }

    BlankView {
        id: blankView
        anchors.fill: parent
        visible: imageBrowser.modelCounts == 0
        onClicked: {
            fileDialog.open()
        }
    }

    FileDialog {
        id: fileDialog
        nameFilters: [ "Image files (*.jpg *.png *jpeg)"]
        acceptLabel: "选择"
        fileMode: FileDialog.OpenFiles
        onAccepted: {
            imageBrowser.viewModel.addImageAssetWithUrl(fileDialog.files)
        }
    }

    // ----- Gesture ------

    DropArea {
        id: fileDrop
        anchors.fill: parent
        onEntered: {
            drapHighlight.visible = true
        }
        onExited: {
            drapHighlight.visible = false
        }
        onDropped: (drop) => {
            console.log(drop.urls)
        }
    }

}
