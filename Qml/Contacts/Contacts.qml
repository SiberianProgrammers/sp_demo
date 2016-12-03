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
        color: "#ffff7f2a"
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
                        if (demoAppLoader.currentIndex === 1) {
                            context.accepted = true
                            backAction()
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
    function backAction() {
        var context = { accepted: false }
        backKeyPressed(context)

        if (!context.accepted) {
            root.goTo(-1);
        }
    } // function backAction() {
}
