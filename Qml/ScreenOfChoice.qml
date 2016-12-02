import QtQuick 2.8
import QtQuick.Layouts 1.1
import SP 1.0

import "qrc:/SpQml"
import "./"
import "qrc:/Components"

//--------------------------------------------------------------------------
// Экран выбора различных приложений
//--------------------------------------------------------------------------
ColumnLayout {
    id: _screenOfChoice

    width: root.width
    spacing: 0
    anchors {
        top: parent.top
        bottom: parent.bottom
        topMargin: Consts.statusBarHeight
    }

    //--------------------------------------------------------------------------
    Item {
        Layout.preferredWidth: root.width
        Layout.minimumHeight: captionObject.height + logo.height + Consts.margin
        Layout.fillHeight: true

        Column {
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: Consts.margin

            Image {
                id: logo
                fillMode: Image.PreserveAspectFit
                source: "qrc:/logo.png"
                anchors.horizontalCenter: parent.horizontalCenter
                width: 13*mm
                height: width
            }

            Text {
                id: captionObject

                text: qsTr("Сибирские\nпрограммисты")
                horizontalAlignment: Text.AlignHCenter
                width: parent.width - 2*Consts.margin
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                font {
                    pixelSize: Consts.fontBig
                    letterSpacing: Consts.fontBigLetterSpacing
                }
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Consts.fontSmall
            } // Text {
        } // Column {
    } // Item {

    //--------------------------------------------------------------------------
    Item {
        Layout.preferredWidth: root.width
        Layout.preferredHeight: buttonsColumn.height

        Column {
            id: buttonsColumn

            property real maxTextWidth: 0

            width: parent.width
            spacing: Consts.marginBig

            Repeater {
                model: demoAppsModel

                //--------------------------------------------------------------------------
                ChoiceButton {
                    id: buttonCamera

                    text: model.text
                    width: Math.ceil(Math.min(0.75*Window.width, buttonsColumn.maxTextWidth + 2*Consts.marginBig))
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: {
                        root.goTo(index)
                    }
                } // ChoiceButton { id: buttonCamera
            }
        } // Column {
    } // Item {

    //--------------------------------------------------------------------------
    Item {
        Layout.preferredWidth: root.width
        Layout.fillHeight: true
        Layout.minimumHeight: 8*mm
        Layout.preferredHeight: 9*mm
        Layout.topMargin: Consts.marginBig

        Text {
            id: tipText

            text: qsTr("Выберите пример\nприложения")
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            color: "#888888"
            font.pixelSize: Consts.fontNormal
            anchors.horizontalCenter: parent.horizontalCenter
        } // Text {
    } // Item {

    //------------------------------------------------------------------------------
    Component.onCompleted: {
        for (var i = 0; i < demoAppsModel.count; ++i) {
            var text = demoAppsModel.get(i).text;
            var textWidth = Consts.fontMetricsTitle.boundingRect(text).width;
            buttonsColumn.maxTextWidth = Math.max(textWidth, buttonsColumn.maxTextWidth);
        }
    }
}
