import QtQuick 2.0

Item {
    width: Window.width
    height: Window.height

    Loader {
        id: rootLoader
        anchors.fill: parent
    }

    Timer {
        interval: 50
        running: true
        onTriggered: {
            Log.info("triggered...")
            rootLoader.source = "qrc:/Root.qml"
        }
    }
}
