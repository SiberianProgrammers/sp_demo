import QtQuick 2.7

import "./"

Item {
    id: _background

    anchors.fill: parent

    //--------------------------------------------------------------------------
    // Фон первого экрана
    //--------------------------------------------------------------------------
    Image {
        id: backgroundImg

        source: "qrc:/background.jpg"
        //source: "qrc:/background1.png"
        fillMode: Image.PreserveAspectCrop
        width : parent.width
        height: parent.height
    }

    //--------------------------------------------------------------------------
    // Фон онлайн-журнала
    //--------------------------------------------------------------------------
    Image {
        id: backgroundImg1

        //source: "qrc:/background.jpg"
        source: "qrc:/background1.png"
        fillMode: Image.PreserveAspectCrop
        width : parent.width
        height: parent.height
        x: rootContainer.x + width
    }

    //--------------------------------------------------------------------------
    Rectangle {
        anchors.fill: backgroundImg1
        color: "black"
        opacity: 0.15
    }

    //--------------------------------------------------------------------------
    Rectangle {
        height: Consts.statusBarHeight
        width: parent.width
        color: "black"
        opacity: 0.1
    }
}
