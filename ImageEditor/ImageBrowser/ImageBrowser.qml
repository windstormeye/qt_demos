import QtQuick 2.0
import com.pjhubs.image_editor 1.0

Rectangle {
    property real modelCounts: 0
    property ImageAsset currentImageAsset: null
    property ImageBrowserViewModel viewModel: null
    property var currentSelectedBox: null

    id: root
    color: "black"

    ImageBrowserViewModel {
        id: vm
        Component.onCompleted: {
            modelCounts = vm.rowCount()
            root.viewModel = vm
        }
    }

    Component {
        id: item
        Rectangle {
            width: gridView.cellWidth
            height: gridView.cellHeight
            border.color: "white"
            border.width: 1

            ImageBrowserItemView {
                id: itemView
                coverUrl: asset.fileUrl
                onSelected: (selectedBox, imgUrl) => {
                                // change selected box visible status when mouse left button clicked.
                                if (selectedBox === root.currentSelectedBox) {
                                    return
                                }
                                if (root.currentSelectedBox) {
                                    root.currentSelectedBox.visible = false
                                }
                                root.currentSelectedBox = selectedBox
                                selectedBox.visible = true

                                let model = viewModel.modelAt(index)
                                if (model) {
                                    currentImageAsset = model;
                                }
                            }
                onSelectedBoxComplated: (selectedBox) => {
                                            // default select import first images when init time.
                                            if (index === 0) {
                                                root.currentSelectedBox = selectedBox
                                                selectedBox.visible = true
                                            }
                }
            }
        }
    }

    GridView {
        id: gridView
        model: viewModel
        delegate: item
        cellWidth: 80
        cellHeight: gridView.height
        anchors.fill: parent

    }

    Connections{
        target: viewModel
        function onDataUpdated() {
            modelCounts = vm.rowCount()

            if (!currentImageAsset) {
                let model = viewModel.modelAt(0)
                if (model) {
                    currentImageAsset = model;
                }
            }

        }
    }
}
