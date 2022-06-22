import QtQuick 2.0
import com.pjhubs.image_editor

Rectangle {
    property ImageAsset imageModel: null

    color: "black"

    Image {
        id: currentImage
        source: imageModel ? "image://localImageProvider/" + imageModel.fileUrl : ""
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
}
