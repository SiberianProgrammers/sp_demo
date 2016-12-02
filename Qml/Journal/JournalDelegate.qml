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
    height: previewContent.articleHeader.height + previewContent.articleImage.height + 3*Consts.margin
    x: Consts.margin

    //--------------------------------------------------------------------------
    // Нужно для корректной анимации ParentChange
    //--------------------------------------------------------------------------
    Rectangle {
        id: _journalItemBackground

        width: Window.width - 2*Consts.margin
        height: previewContent.articleHeader.height + previewContent.articleImage.height + 3*Consts.margin
        anchors.horizontalCenter: parent.horizontalCenter
        radius: Consts.radius
        clip: true

        // Смещение ActionBar'a "выталкиванием" карточкой
        onYChanged: {
            if (!actionBar.animationEnabled && visualStatesItem.openedArticle) {
                var yMap = mapToItem(_journal, 0, 0).y
                if (yMap < 0) {
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

            // Изменение положения кнопки назад
            onContentYChanged: {
                backButton.yShift = Math.min(0, -contentY + previewContent.articleImage.height - 5*Consts.margin)
            }

            //------------------------------------------------------------------
            Column {
                id: contentColumn

                width: parent.width
                spacing: 1.5*Consts.margin

                //--------------------------------------------------------------
                // Контент видимый всегда
                //--------------------------------------------------------------
                PreviewContent {
                    id: previewContent
                }

                //--------------------------------------------------------------
                // Контент видимый при раскрытии карточки
                //--------------------------------------------------------------
                AdditionalContent {
                    id: additionalContent
                }
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
