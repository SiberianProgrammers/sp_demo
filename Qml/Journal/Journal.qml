import QtQuick 2.7
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Онлайн журнал
//--------------------------------------------------------------------------
Item {
    id: _journal

    signal backKeyPressed(var context)

    width: parent.width
    anchors {
        top: parent.top
        bottom: parent.bottom
        topMargin: Consts.statusBarHeight
    }

    //--------------------------------------------------------------------------
    ActionBar {
        id: actionBar

        title: "Онлайн Журнал"
        z: 1
        opacity: 0.75
        color: "transparent"
        //titleColor: "black"
        titleColor: "white"
        titleAlignment: Text.AlignHCenter
    } // ActionBar {

    //--------------------------------------------------------------------------
    BackButton {
        id: backButton

        //arrowColor: "black"
        arrowColor: "white"
        height: 1.5*Consts.margin
        opacity: 0.75

        anchors {
            top: parent.top
            left: parent.left
            margins: Consts.margin
        }

        onClicked: {
            backAction()
        }

        //--------------------------------------------------------------------------
        Connections {
            target: root.keysHandler
            onBackKeyPressed: {
                if (demoAppLoader.currentIndex === 1) {
                    context.accepted = true
                    backAction()
                }
            }
        } // Connections {
    } // BackButton {


    //--------------------------------------------------------------------------
    JournalModel { id: journalModel }

    //--------------------------------------------------------------------------
    JournalView {
        id: journalView
    }

    //--------------------------------------------------------------------------
    function backAction() {
        var context = { accepted: false }
        _journal.backKeyPressed(context)

        if (!context.accepted) {
            root.goTo(-1);
        }
    } // function backAction() {
}
