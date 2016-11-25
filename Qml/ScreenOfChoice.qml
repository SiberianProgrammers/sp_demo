import QtQuick 2.8

import "qrc:/SpQml"
import "./"
import "qrc:/Components"

//--------------------------------------------------------------------------
// Экран выбора различных приложений
//--------------------------------------------------------------------------
Item {
    id: _screenOfChoice

    height: root.height
    width: root.width

    //--------------------------------------------------------------------------
    Text {
        id: captionObject

        // TODO - вынести в config.
        text: qsTr("Сибирские программисты")
        horizontalAlignment: Text.AlignHCenter
        width: parent.width - 2*Consts.margin
        color: "black"
        anchors {
            top: parent.top
            topMargin: 3*Consts.marginBig + Consts.statusBarHeight
            horizontalCenter: parent.horizontalCenter
        }
        font {
            pixelSize: Consts.fontBig
            letterSpacing: Consts.fontBigLetterSpacing
        }
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    } // TextBig {

    //--------------------------------------------------------------------------
    Column {
        id: column

        width: parent.width
        spacing: 2*Consts.margin
        anchors {
            centerIn: parent
            verticalCenterOffset: 0.75*captionObject.height //+ captionObject.anchors.topMargin
        }

        //--------------------------------------------------------------------------
        Text {
            text: qsTr("Выберите интересующий Вас пример")
            horizontalAlignment: Text.AlignHCenter
            width: 0.8*_screenOfChoice.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            font.pixelSize: Consts.fontNormal
        } // Text {

        //--------------------------------------------------------------------------
        ChoiceButton {
            id: buttonCamera

            text: qsTr("Камера")
            maxWidth: 0.75*Window.width
            width: Math.max(buttonContacts.contentWidth, buttonJournal.contentWidth, buttonCamera.contentWidth)
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                root.goTo(0)
            }
        } // ChoiceButton { id: buttonCamera

        //--------------------------------------------------------------------------
        ChoiceButton {
            id: buttonJournal

            text: qsTr("Онлайн журнал")
            maxWidth: 0.75*Window.width
            width: Math.max(buttonContacts.contentWidth, buttonJournal.contentWidth, buttonCamera.contentWidth)
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                root.goTo(1)
            }
        } // ChoiceButton { id: buttonJournal

        //--------------------------------------------------------------------------
        ChoiceButton {
            id: buttonContacts

            text: qsTr("Список контаков")
            maxWidth: 0.75*Window.width
            width: Math.max(buttonContacts.contentWidth, buttonJournal.contentWidth, buttonCamera.contentWidth)
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                root.goTo(2)
            }
        } // ChoiceButton { id: buttonContacts
    } // Column {
}
