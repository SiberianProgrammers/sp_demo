import QtQuick 2.8
import SP 1.0

import "../"

Item {
    id: blockImage

    width: parent.width
    height: imageParallax.height + caption.height

    //Сделать паралакс
    ImageSp {
        id: imageParallax

        source: model.blockData[0] //"qrc:/Journal/trump.png"
        width: parent.width
        height: 0.4*Window.height
    }

    Text {
        id: caption

        text: model.blockData[1] !== undefined
                ? model.blockData[1]
                : ""
        width: blockImage.width
        opacity: 0.5
        font.pixelSize: Consts.fontSmall
        elide: Text.ElideRight
        anchors.top: imageParallax.bottom
    }

}
