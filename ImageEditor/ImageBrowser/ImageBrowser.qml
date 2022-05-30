import QtQuick 2.0
import com.pjhubs.image_editor 1.0

Rectangle {
    property real modelCounts: 0
    property ImageAsset currentImageAsset: null
    property ImageBrowserViewModel viewModel: null

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
            ImageBrowserItemView {
                id: itemView
                coverUrl: asset.fileUrl
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
