import QtQuick 2.8
import SP 1.0

import "../"
import "./"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
Item {
    id: _journalDelegate

    width: Window.width - 2*Consts.margin
    // Костыль... из-за этого глючила анимация
    height: articleHeader.height + articleImage.height + 3*Consts.margin
    x: Consts.margin

    //--------------------------------------------------------------------------
    // Нужно для корректной анимации ParentChange
    //--------------------------------------------------------------------------
    Rectangle {
        id: _journalItemBackground

        width: Window.width - 2*Consts.margin
        height: articleHeader.height + articleImage.height + 3*Consts.margin
        anchors.horizontalCenter: parent.horizontalCenter
        radius: Consts.radius
        clip: true

        onYChanged: {
            if (!actionBar.animationEnabled && visualStatesItem.openedArticle) {
                var yMap = mapToItem(_journal, 0, 0).y
                if (yMap < 0) {
                    //statusBar.opacity = 0.5
                    actionBar.animationEnabled = true
                    actionBar.y = - actionBar.height - Consts.statusBarHeight
                } else if (yMap < actionBar.height + Consts.statusBarHeight) {

                    actionBar.y = yMap - actionBar.height - Consts.statusBarHeight
                }
            }
        }

        //--------------------------------------------------------------------------
        // Содержимое с прокруткой
        //----------------------------------------------------------------------
        Flickable {
            id: contentFlickable

            height: _journalDelegate.height
            width: _journalDelegate.width
            contentHeight: contentColumn.height
            clip: true

            onContentYChanged: {
                backButton.anchors.topMargin = Math.min(Consts.margin, -contentY + articleImage.height - 5*Consts.margin)
            }

            //------------------------------------------------------------------
            Column {
                id: contentColumn

                width: parent.width
                spacing: 1.5*Consts.margin

                //--------------------------------------------------------------
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

                //--------------------------------------------------------------
                // Заголовок
                //--------------------------------------------------------------
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

                //--------------------------------------------------------------
                // Раскрытый текст
                //--------------------------------------------------------------
                Item {
                    id: articleContentItem

                    width: Window.width - 6*Consts.margin
                    height: articleContent.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: articleContent

                        //text: model.content - выставляется в VisualStatesItem
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

            //------------------------------------------------------------------
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

    //--------------------------------------------------------------------------
    Connections {
        target: _journal
        onBackKeyPressed: {
            if (visualStatesItem.openedArticle) {
                visualStatesItem.hideArticle()
                context.accepted = true
            }
        } // onBackKeyPressed: {
    } // Connections {

    //--------------------------------------------------------------------------
    VisualStatesItem {
        id: visualStatesItem
    }
}
