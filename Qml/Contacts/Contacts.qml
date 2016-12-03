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
        leftButton.sourceComponent:
            BackButton {
                arrowColor: "white"
                y: Math.ceil((Consts.actionBarHeight - height)/2)
                z: actionBar.z

                Connections {
                    target: root.keysHandler
                    onBackKeyPressed: {
                        if (!context.accepted) {
                            context.accepted = true;
                            backAction();
                        }
                    }
                }

                onClicked: {
                    backAction()
                }
            } // BackButton {

        //rightButton.sourceComponent: SearchButton { }
        rightButton.sourceComponent: Item { width: height; height: parent.height }
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
