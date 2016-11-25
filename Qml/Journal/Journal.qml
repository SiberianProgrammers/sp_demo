import QtQuick 2.8
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

        property bool animationEnabled: false
        title: "Онлайн Журнал"
        titleColor: "white"
        color: "#517da2"
        titleAlignment: Text.AlignHCenter
        width: Window.width
        y: 0
        z: 1

        Behavior on y {
            enabled: actionBar.animationEnabled
            NumberAnimation { duration: 250 }
        }

        onYChanged: {
            statusBar.opacity = y <= -height
                                ? 0.5
                                : 1.0;
        }
    } // ActionBar {

    //--------------------------------------------------------------------------
    BackButton {
        id: backButton

        arrowColor: "white"
        height: 2.5*Consts.margin
        opacity: 0.75
        z: actionBar.z
        borderColor: "gray"

        anchors {
            top: parent.top
            left: parent.left
            topMargin: Consts.margin
            leftMargin: Consts.margin
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
