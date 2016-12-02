import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

MaterialButton {
    id: _button

    readonly property double contentWidth: textItem.contentWidth + 2*Consts.margin + 2*radius

    color: "#55ffffff"

    height: Math.ceil(textItem.height + 2*Consts.margin+2*border.width)
    radius: 0.25*height

    durationAnimationPressed: 300
    durationAnimationReleased: 200
    pressedPlaceOpacity: 0.2

    textItem {
        width: _button.width - 2*Consts.margin
        font.pixelSize: Consts.fontTitle
        horizontalAlignment: Text.AlignHCenter
        color: "black"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    border {
        width: Consts.borderWidth
        color: "#55888888"
    }
}
