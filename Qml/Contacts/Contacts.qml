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

        rightButton.sourceComponent: SearchButton { }
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
    ListModel {
        id: contactsModel

        ListElement {
            name: "Серебренников Михаил"
            company: "Сибирские Программисты"
            position: "директор"
            profileData: [
                ListElement { value: "+7(950)-1-46-46-65"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ]
        }
        ListElement {
            name: "Грибанов Алексей"
            company: "Сибирские Программисты"
            position: "соучредитель"
            profileData: [
                ListElement { value: "+7(914)-924-42-46"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ]
        }
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
