import QtQuick 2.8
import "../"

Row {
    id: _blockQuoteLarge

    spacing: Consts.margin

    Rectangle {
        id: line

        width: Math.ceil(0.75*mm)
        height: column.height + Consts.margin
        color: "grey"
    }

    Column {
        id: column

        anchors.verticalCenter: line.verticalCenter
        width: parent.width

        Text {
            text: model.blockData[0]
            width: parent.width
            opacity: 0.75
            font {
                pixelSize: Consts.fontBig
                italic: true
            }
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Text {
            text: model.blockData[1]
            opacity: 0.75
            font.pixelSize: Consts.fontNormal
            anchors.right: parent.right
        }
    }
}
