import QtQuick 2.0
import com.pjhubs.image_editor

Rectangle {
    property ImageAsset imageModel: null

    color: Qt.rgba(50/255, 50/255, 50/255, 1)

    Image {
        id: currentImage
        source: imageModel ? imageModel.fileUrl : ""
        anchors.fill: parent
    }
}
