import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

Item {
    id: _previewContent

    readonly property alias articleImage: articleImage
    readonly property alias openArticleMouseArea: openArticleMouseArea
    readonly property alias articleHeader: articleHeader

    width: parent.width
    height: column.height

    Column {
        id: column

        width: parent.width
        spacing: Consts.margin

        //--------------------------------------------------------------
        // Картинка новости
        //--------------------------------------------------------------
        ImageParallax {
            id: articleImage

            source: model.imageSource
            width: parent.width
            height: 0.3*Window.height
            delegate: _journalDelegate
            relativeItem: journalView
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: imageMouseArea
                anchors.fill: parent

                onClicked: {
                    visualStatesItem.openFullScreen(0)
                }
            }
        } // ImageParallax {

        //--------------------------------------------------------------
        // Заголовок
        //--------------------------------------------------------------
        Item {
            width: parent.width
            height: articleHeader.height + dateObject.height + Consts.spacing

            Text {
                id: articleHeader

                text: model.caption
                //WIDTH
                //width: Window.width - 4*Consts.margin
                width: Window.width - 2*Consts.marginBig
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    pixelSize: Consts.fontTitle
                    //weight: Font.Medium
                    bold: true
                }
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                antialiasing: false
            } // Text {

            Text {
                id: dateObject
                text: model.date//qsTr("3 декабря 2016 г.")
                anchors {
                    left: parent.left
                    leftMargin: Consts.marginBig
                    bottom: parent.bottom
                }

                //anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Consts.fontSmall
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                opacity: 0.75
                antialiasing: false
            } // Text { id: dateObject
        } // Item {
    }

    //--------------------------------------------------------------
    MouseArea {
        id: openArticleMouseArea
        anchors.fill: parent
        onClicked: {
            if (!visualStatesItem.openedArticle) {
                visualStatesItem.openArticle()
            }
        }
    } // MouseArea {id: openArticleMouseArea
}
