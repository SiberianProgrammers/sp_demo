import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Экран онлайн-журнала
//--------------------------------------------------------------------------
Rectangle {
    id: _journal

    signal backKeyPressed(var context)
    color: Consts.lightGray

    //--------------------------------------------------------------------------
    ActionBar {
        id: actionBar

        property bool animationEnabled: false

        title: "Онлайн Журнал"
        titleColor: "white"
        color: "#517da2"
        titleAlignment: Text.AlignHCenter
        width: Window.width
        z: 1

        Behavior on y {
            enabled: actionBar.animationEnabled
            NumberAnimation { duration: 250 }
        }
    } // ActionBar {

    //--------------------------------------------------------------------------
    // BackButton отдельно от ActionBar, т.к. карточка выталкивает ActionBar за
    // пределы экрана
    //--------------------------------------------------------------------------
    BackButton {
        id: backButton

        arrowColor: "white"
        height: 2.5*Consts.margin
        y: Math.ceil((Consts.actionBarHeight - height)/2)
        z: actionBar.z
        anchors {
            left: parent.left
            leftMargin: Consts.margin
        }

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

    //--------------------------------------------------------------------------
    ArticlesPreviewModel { id: journalModel }
    ArticleBlocksModel { id: articleBlocksModel }

    //--------------------------------------------------------------------------
    JournalView {
        id: journalView
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
