import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Кнопка поиска по контактам
//--------------------------------------------------------------------------
MaterialButton {
    id: searchButton
    color: "transparent"
    width: height-2*Consts.spacing
    radius: height/2
    border.width: 0
    pressedColor: "black"

    Image {
        source: "qrc:/Contacts/Search.png"

        readonly property int originalHeight: isDesktop
                                              ? Math.ceil(2.8*mm)
                                              : Math.ceil(2.5*mm)
        height: originalHeight % 2 === 0
                ? originalHeight
                : originalHeight + 1
        width: height
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
}
