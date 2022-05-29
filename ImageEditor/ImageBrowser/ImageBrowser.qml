import QtQuick 2.0
import com.pjhubs.image_editor 1.0

Rectangle {
    id: root
    property real modelCounts: 0
    property ImageBrowserViewModel viewModel: null

    color: "black"


    ImageBrowserViewModel {
        id: vm
        Component.onCompleted: {
            modelCounts = vm.rowCount()
            root.viewModel = vm
        }
    }

    Rectangle {
        id: item0
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "gray"
    }

    Rectangle {
        width: 80
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: item0.right
        anchors.leftMargin: 10
        color: "gray"
    }

    Connections{
        target: viewModel
        function onDataUpdated() {
            modelCounts = vm.rowCount()
        }
    }
}
