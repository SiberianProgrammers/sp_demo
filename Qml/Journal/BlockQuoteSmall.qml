import QtQuick 2.8
import "../"

Row {
    id: _blockQuoteLarge

    spacing: Consts.margin

    Rectangle {

        id: line
        width: Math.ceil(0.75*mm)
        height: textObject.height + Consts.margin
        color: "grey"
    }

    Text {
        id: textObject

        anchors.verticalCenter: line.verticalCenter
        text: model.blockData[0] + " " + model.blockData[1]
        width: parent.width
        opacity: 0.75
        font.pixelSize: Consts.fontNormal
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }
}
