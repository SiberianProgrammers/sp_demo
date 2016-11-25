import QtQuick 2.8

import "../"

//--------------------------------------------------------------------------
// Состояние карточки развернута/нет
//--------------------------------------------------------------------------
Item {
    id: _visualStatesItem

    property bool openedArticle: false

    //--------------------------------------------------------------------------
    state: "preview"
    states: [
        State {
            name: "preview"
            PropertyChanges {
                target: contentFlickable
                interactive: false
                contentY: 0
            }

            PropertyChanges {
                target: journalView
                interactive: true
            }

            PropertyChanges {
                target: articleContent
                anchors.bottomMargin: -0.25*_journalItemBackground.height
            }

            PropertyChanges {
                target: actionBar
                shadowVisible: true
            }

            ParentChange {
                target: _journalItemBackground
                parent: _journalDelegate
                height: articleHeader.height + articleImage.height + 3*Consts.margin
                width : Window.width - 2*Consts.margin
                x: 0
                y: 0
            }
        }
        , State {
            name: "fullsize"

            ParentChange {
                target: _journalItemBackground
                parent: _journal
                height: _journal.height + Consts.statusBarHeight
                width : _journal.width
                x: 0
                y: - Consts.statusBarHeight
            }

            PropertyChanges {
                target: articleContent
                anchors.bottomMargin: 0
            }

            PropertyChanges {
                target: _journalDelegate
                height: _journal.height
                width: _journal.width
                x: 0
            }

            PropertyChanges {
                target: contentFlickable
                interactive: true
                contentY: 0
            }

            PropertyChanges {
                target: journalView
                interactive: false
            }

            PropertyChanges {
                target: actionBar
                shadowVisible: false
            }

//            PropertyChanges {
//                target: statusBar
//                opacity: 0.5
//            }
        }
    ] // states: [

    //--------------------------------------------------------------------------
    transitions: [
        Transition {
            to: "fullsize"

            NumberAnimation {
                target: actionBar
                easing.type: Easing.OutQuad
                property: "y"
                duration: 250
            }

            PropertyAction {
                target: articleContent;
                property: "text";
                value: model.content.replace(/(\r\n|\n|\r)/gm,"")
            }

            ParentAnimation {
                //via: journalView
                via: _journal
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    properties: "x,y,width,height"
                    duration: 400
                }
            }

            NumberAnimation {
                target: statusBar
                easing.type: Easing.OutQuad
                property: "opacity"
                duration: 400
            }

            NumberAnimation {
                easing.type: Easing.OutQuad
                property: "anchors.bottomMargin"
                duration: 500
            }
        }
        , Transition {
            to: "preview"

            NumberAnimation {
                target: actionBar
                easing.type: Easing.OutQuad
                property: "y"
                duration: 250
            }

            NumberAnimation {
                target: statusBar
                easing.type: Easing.OutQuad
                property: "opacity"
                duration: 200
            }

            SequentialAnimation {
                NumberAnimation {
                    properties: "contentY"
                    duration: 0
                }

                NumberAnimation {
                    easing.type: Easing.OutQuad
                    properties: "anchors.bottomMargin"
                    duration: 200
                }

                PropertyAction {
                    target: articleContent;
                    property: "text";
                    value: ""
                }
            }

            SequentialAnimation {
                ParentAnimation {
                    via: journalView

                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        properties: "x,y,width,height"
                        duration: 400
                    }
                }

                PropertyAction {
                    target: articleImage;
                    property: "freezed";
                    value: false
                }
            }
        }
    ] // transitions: [

    //--------------------------------------------------------------------------
    function openArticle() {
        Log.info("openArticle iindex = " + index)
        articleImage.freezed = true
        actionBar.animationEnabled = false
        _visualStatesItem.state = "fullsize"
        _visualStatesItem.openedArticle = true
    } // function openArticle() {

    //--------------------------------------------------------------------------
    function hideArticle() {
        Log.info("hideArticle index = " + index)
        _visualStatesItem.openedArticle = false
        actionBar.animationEnabled = true
        actionBar.y = 0
        statusBar.opacity = 1.0
        _visualStatesItem.state = "preview"
    }
}
