import QtQuick 2.8

import "./"

Item {
    id: _background

    anchors.fill: parent

    //--------------------------------------------------------------------------
    Image {
        id: image

        anchors.fill: parent
        source: "qrc:/background.png"
        fillMode: Image.PreserveAspectCrop
    }
}
