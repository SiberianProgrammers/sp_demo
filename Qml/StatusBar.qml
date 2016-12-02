import QtQuick 2.8
import "./"

Item {
    id: _statusBar

    width: root.width
    height: Consts.statusBarHeight
    x: screenOfChoice.x
    z: 999999

    //--------------------------------------------------------------------------
    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.2
    }

    //--------------------------------------------------------------------------
    Rectangle {
        width: parent.width
        height: parent.height
        color: "#416480"
        anchors.left: parent.right
    }
}
