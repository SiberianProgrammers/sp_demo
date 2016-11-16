import QtQuick 2.7

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
            }
            PropertyChanges {
                target: journalView
                interactive: true
            }

            PropertyChanges {
                target: articleContent
                anchors.bottomMargin: -0.5*_journalItemBackground.height
            }

            PropertyChanges {
                target: actionBar
                shadowVisible: true
            }
        }
        , State {
            name: "fullsize"

            ParentChange {
                target: _journalItemBackground
                parent: _journal
                x: 0
                y: actionBar.height
                width: _journal.width
                height: _journal.height
            }

            PropertyChanges {
                target: articleContent
                anchors.bottomMargin: 0
            }

            PropertyChanges {
                target: _journalDelegate
                height: _journal.height
                width: _journal.width
            }

            PropertyChanges {
                target: contentFlickable
                interactive: true
            }

            PropertyChanges {
                target: journalView
                interactive: false
            }

            PropertyChanges {
                target: actionBar
                shadowVisible: false
            }
        }
    ] // states: [

    //--------------------------------------------------------------------------
    transitions: [
        Transition {
            to: "fullsize"

            PropertyAction {
                target: articleContent;
                property: "text";
                value: model.content.replace(/(\r\n|\n|\r)/gm,"")
            }

            NumberAnimation {
                easing.type: Easing.OutQuad
                properties: "opacity,anchors.margins,imageShift,contentY,imageParalaxHeight"
                duration: 300
            }

            ParentAnimation {
                via: journalView
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    properties: "x,y,width,height"
                    duration: 400
                }
            }

            NumberAnimation {
                easing.type: Easing.OutQuad
                property: "anchors.bottomMargin"
                duration: 600
            }
        }
        , Transition {
            to: "preview"

            PropertyAction {
                target: articleContent;
                property: "text";
                value: ""
            }

            NumberAnimation {
                easing.type: Easing.OutQuad
                properties: "opacity,anchors.margins,imageShift,contentY,imageParalaxHeight"
                duration: 350
            }

            ParentAnimation {
                via: journalView
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    properties: "x,y,width,height"
                    duration: 400
                }
            }
        }
    ] // transitions: [

    //--------------------------------------------------------------------------
    function openArticle() {
        _visualStatesItem.state = "fullsize"
        _visualStatesItem.openedArticle = true
    } // function openArticle() {

    //--------------------------------------------------------------------------
    function hideArticle() {
        _visualStatesItem.state = "preview"
        _visualStatesItem.openedArticle = false
    }
}
