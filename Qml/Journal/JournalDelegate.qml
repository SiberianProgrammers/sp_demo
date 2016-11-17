import QtQuick 2.7
import SP 1.0

import "../"
import "./"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
Item {
    id: _journalDelegate

    width: Window.width - 2*Consts.margin
    height: contentColumn.height
    anchors.horizontalCenter: parent.horizontalCenter

    //--------------------------------------------------------------------------
    // Нужно для корректной анимации ParentChange
    //--------------------------------------------------------------------------
    Rectangle {
        id: _journalItemBackground
        width: parent.width
        height: parent.height

        anchors.horizontalCenter: parent.horizontalCenter

        //--------------------------------------------------------------------------
        // Содержимое с прокруткой
        //--------------------------------------------------------------------------
        Flickable {
            id: contentFlickable

            height: _journalDelegate.height
            width: _journalDelegate.width
            contentHeight: contentColumn.height
            // Убрал специально, иначе коллизии с mouseArea.
            //boundsBehavior: Flickable.StopAtBounds
            clip: true

            //--------------------------------------------------------------------------
            Column {
                id: contentColumn

                width: parent.width
                topPadding: 1.5*Consts.margin
                spacing: 1.5*Consts.margin

                //--------------------------------------------------------------------------
                // Заголовок
                //--------------------------------------------------------------------------
                Text {
                    id: articleHeader

                    text: model.header
                    width: Window.width - 4*Consts.margin
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    font {
                        pixelSize: Consts.fontNormal
                        bold: true
                    }
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    opacity: 0.75
                }

                //--------------------------------------------------------------------------
                // Картинка новости
                //--------------------------------------------------------------------------

                ImageParallax {
                    id: articleImage

                    source: "qrc:/Journal/trump.png"
                    width: parent.width
                    height: 0.4*Window.height
                    delegate: _journalDelegate
                    relativeItem: journalView
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                //--------------------------------------------------------------------------
                // Раскрытый текст
                //--------------------------------------------------------------------------
                Item {
                    id: articleContentItem

                    width: _journalDelegate.width - 4*Consts.margin
                    height: articleContent.height
                    visible: articleContent.visible
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: articleContent

                        //text: model.content - выставляется в VisualStatesItem
                        visible: text !== ""
                        width: articleContentItem.width
                        opacity: 0.75
                        font.pixelSize: Consts.fontNormal
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        textFormat: Text.StyledText
                        //horizontalAlignment: Text.AlignJustify

                        anchors {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                    } // Text { id: articleContent
                } // Item { id: articleContentItem
            } // Column { id: contentColumn

            //--------------------------------------------------------------------------
            MouseArea {
                anchors.fill: contentColumn
                onClicked: {
                    if (!visualStatesItem.openedArticle) {
                        visualStatesItem.openArticle()
                    } else {
                        visualStatesItem.hideArticle()
                    }
                }
            } // MouseArea {
        } // Flickable {
    } // Rectangle { id: _journalItemBackground

    Connections {
        target: _journal
        onBackKeyPressed: {
            if (visualStatesItem.openedArticle) {
                visualStatesItem.hideArticle()
                context.accepted = true
            }
        } // onBackKeyPressed: {
    } // Connections {

    VisualStatesItem {
        id: visualStatesItem
    }
}
