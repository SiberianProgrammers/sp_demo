import QtQuick 2.8
import "../"

Text {
    text: model.blockData
    width: parent.width
    opacity: 0.5
    font.pixelSize: Consts.fontSmall
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
}
