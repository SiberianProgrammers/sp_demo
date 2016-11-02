import QtQuick 2.7
import DXS 1.0
import "./"
import "qrc:/DxsQml"

Item {
    id: root

    width: Window.width
    height: Window.height

    //--------------------------------------------------------------------------
    ActionBar {
        id: actionBar
    }

    //--------------------------------------------------------------------------
    Rectangle {
        id: background

        color: Consts.lightGray
        z: -1
    }

    //--------------------------------------------------------------------------
    // Загрузчик различных
    //--------------------------------------------------------------------------
    Loader {
        id: contentLoader
        anchors.fill: parent
    }
}
