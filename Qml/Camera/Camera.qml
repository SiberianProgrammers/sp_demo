import QtQuick 2.7

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
Item {
    width: parent.width
    height: parent.height

    //--------------------------------------------------------------------------
    BackButton {
        height: 1.5*Consts.margin
        anchors {
            top: parent.top
            left: parent.left
            margins: Consts.margin
        }

        onClicked: {
            root.goTo(-1);
        }
    }

    //--------------------------------------------------------------------------
    Loader {
        id: cameraLoader

        //source: "qrc:/Camera/CameraContainer.qml"
        anchors.fill: parent
    }

    // TODO добавить BusyIndicator

    //--------------------------------------------------------------------------
    Timer {
        id: showTimer

        interval: 350
        running: true
        onTriggered: {
            cameraLoader.source = "qrc:/Camera/CameraContainer.qml"
        }
    }
}
