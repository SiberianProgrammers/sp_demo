import QtQuick 2.8
import "./"

Item {

    readonly property alias statusBar: statusBar

    anchors.fill: parent

    //--------------------------------------------------------------------------
    Rectangle {
        id: statusBar
        height: Consts.statusBarHeight
        width: parent.width
        color: "#416480"
        z: 999999
        x: Window.width + rootContainer.x

        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }
    }

    //--------------------------------------------------------------------------
    Rectangle {
        height: Consts.statusBarHeight
        width: parent.width
        color: "black"
        z: 999999
        opacity: 0.2
        x: rootContainer.x
    }

}
