import QtQuick 2.8

import "qrc:/SpQml"

Item {
    id: _main

    readonly property alias keysHandler: keysHandler
    readonly property alias toast: toast

    width: Window.width
    height: Window.height

    Keys.forwardTo: keysHandler

    KeysHandler { id: keysHandler }
    Toast       { id: toast }

    //--------------------------------------------------------------------------
    Loader {
        id: rootLoader
        anchors.fill: parent
    }

    //--------------------------------------------------------------------------
    Timer {
        id: startTimer

        interval: 50
        onTriggered: {
            Log.info("Main.qml::startTimer triggered!")
            rootLoader.source = "qrc:/Root.qml"
        }
    }

    Component.onCompleted: {
        startTimer.start()
    }
}
