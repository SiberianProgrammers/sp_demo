import QtQuick 2.8
import "../"

Text {
    text: model.blockData
    width: parent.width
    opacity: 0.75
    font.pixelSize: Consts.fontTitle
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
}
