import QtQuick 2.8
import "../"

//--------------------------------------------------------------------------
// Состояние карточки развернута/нет
//--------------------------------------------------------------------------
Item {
    id: _visualStatesItem

    property bool openedArticle: false

    signal startHideAnimation()
    signal startOpenAnimation()
    signal stopHideAnimation()
    signal stopOpenAnimation()

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
                target: additionalContent.articleContent
                anchors.topMargin: 0.25*_journalItemBackground.height
            }
            PropertyChanges {
                target: actionBar
                shadowVisible: true
            }
//            ParentChange {
//                target: _journalItemBackground
//                parent: _journalDelegate
//                height: previewContent.articleHeader.height + previewContent.articleImage.height + 3*Consts.margin
//                width : Window.width - 2*Consts.margin
//                x: 0
//                y: 0
//            }
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
                target: additionalContent.articleContent
                anchors.topMargin: 0
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
                height: Window.height
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

            ScriptAction {
                script: {
                    _visualStatesItem.startOpenAnimation()
                }
            }

            NumberAnimation {
                target: actionBar
                easing.type: Easing.OutQuad
                property: "y"
                duration: 250
            }
            PropertyAction {
                target: additionalContent.articleContent;
                property: "text";
                //DEBUG!!! Тут нужен коментарий.
                value: model.summary.replace(/(\r\n|\n|\r)/gm,"")
            }
            ParentAnimation {
                via: _journal
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    properties: "x,y,width,height"
                    duration: 250
                }
            }
            NumberAnimation {
                target: statusBar
                easing.type: Easing.OutQuad
                property: "opacity"
                duration: 250
            }

            SequentialAnimation {
                NumberAnimation {
                    easing.type: Easing.OutQuad
                    property: "anchors.topMargin"
                    duration: 300
                }
                ScriptAction {
                    script: {
                        _visualStatesItem.stopOpenAnimation()
                    }
                }
            }
        }

        , Transition {
            to: "preview"

            ScriptAction {
                script: {
                    _visualStatesItem.startHideAnimation()
                }
            }

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
                    properties: "anchors.topMargin"
                    duration: 200
                }

                PropertyAction {
                    target: additionalContent.articleContent;
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
                    target: previewContent.articleImage;
                    property: "freezed";
                    value: false
                }

                ScriptAction {
                    script: {
                        _visualStatesItem.stopHideAnimation()
                    }
                }
            }
        }
    ] // transitions: [

    //--------------------------------------------------------------------------
    function openArticle() {
        previewContent.articleImage.freezed = true
        actionBar.animationEnabled = false
        _visualStatesItem.state = "fullsize"
        _visualStatesItem.openedArticle = true
    } // function openArticle() {

    //--------------------------------------------------------------------------
    function hideArticle() {
        _visualStatesItem.openedArticle = false
        actionBar.animationEnabled = true
        actionBar.y = 0
        _visualStatesItem.state = "preview"
    }
}
