import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

MaterialButton {
    id: _button

    property real maxWidth: Window.width
    readonly property real contentWidth: textItem.contentWidth + 2*Consts.margin + 2*radius

    color: "transparent"

    height: textItem.height + 2*Consts.margin
    radius: 0.25*height

    durationAnimationPressed: 300
    durationAnimationReleased: 200
    pressedPlaceOpacity: 0.2

    textItem {
        width: _button.maxWidth - 2*Consts.margin
        font.pixelSize: Consts.fontNormal
        horizontalAlignment: Text.AlignHCenter
        //color: "white"
        color: "black"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    border {
        width: Consts.borderWidth
        //color: "#416480"
        color: "gray"
    }
}
