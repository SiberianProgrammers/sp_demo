import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Экран списка контактов
//--------------------------------------------------------------------------
Rectangle {
    id: _contacts

    signal backKeyPressed(var context)

    ActionBar {
        id: actionBar

        title: "Список контактов"
        titleColor: "white"
        color: Consts.contactColor
        titleAlignment: Text.AlignHCenter
        width: Window.width
        z: 1
        leftButton.sourceComponent: BackButton {
            id: backButton
            arrowColor: "white"
            y: Math.ceil((Consts.actionBarHeight - height)/2)
            z: actionBar.z

            Connections {
                target: root.keysHandler
                onBackKeyPressed: {
                    if (!context.accepted && backButton.enabled && backButton.visible) {
                        context.accepted = true;
                        backAction();
                    }
                }
            }

            onClicked: {
                backAction()
            }
        } // BackButton {

        //rightButton.sourceComponent: SearchButton { visible: false }
        rightButton.sourceComponent: Item { width: Consts.actionBarHeight-Consts.marginBig; height: width }
    } // ActionBar {

    //--------------------------------------------------------------------------
    // Список контактов
    //--------------------------------------------------------------------------
    ContactsView {
        id: contactsView
    }

    //--------------------------------------------------------------------------
    // Анкета контакта
    //--------------------------------------------------------------------------
    ProfileView {
        id: profileView
    }

    //--------------------------------------------------------------------------
    // Модель списка контактов
    // Затем должна брать данные из списка контактов Android
    //--------------------------------------------------------------------------
    ContactsModel {
        id: contactsModel
    } // ListModel { id: contactsModel

    //--------------------------------------------------------------------------
    function backAction() {
        var context = { accepted: false }
        backKeyPressed(context)

        if (!context.accepted) {
            root.goTo(-1);
        }
    } // function backAction() {
}
