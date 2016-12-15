import QtQuick 2.8
import SP 1.0

import "../"

Item {
    id: blockImage

    width: parent.width
    height: caption.text === ""
            ? imageParallax.height
            : imageParallax.height + caption.height

    //Сделать паралакс
    ImageSp {
        id: imageParallax

        source: model.blockData[0] //"qrc:/Journal/trump.png"
        //width: parent.width
        width: Window.width
        anchors.horizontalCenter: parent.horizontalCenter
        height: 0.4*Window.height
    }

    Text {
        id: caption

        text: model.blockData[2] === undefined
                ? ""
                : model.blockData[1]
        width: blockImage.width
        opacity: 0.5
        font.pixelSize: Consts.fontSmall
        elide: Text.ElideRight
        anchors.top: imageParallax.bottom
    }

    MouseArea {
        id: imageMouseArea
        anchors.fill: parent

        onClicked: {
            if (model.blockData[2] === undefined) {
                visualStatesItem.openFullScreen(parseInt(model.blockData[1]))
            } else {
                visualStatesItem.openFullScreen(parseInt(model.blockData[2]))
            }

        }
    }

}
