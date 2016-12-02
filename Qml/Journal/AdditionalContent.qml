import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

Item {
    id: _additionalContent

    readonly property alias articleContent: articleContent
    readonly property var blockDelegate: ( {
                                 0: "qrc:/Journal/BlockCaption.qml"
                                 , 1: "qrc:/Journal/BlockText.qml"
                                 , 2: "qrc:/Journal/BlockSummary.qml"
                                 , 3: "qrc:/Journal/BlockImage.qml"
                                 , 4: "qrc:/Journal/BlockDate.qml"
                                 , 5: "qrc:/Journal/BlockAuthor.qml"
                                 , 6: "qrc:/Journal/BlockQuoteSmall.qml"
                                 , 7: "qrc:/Journal/BlockQuoteLarge.qml"
                                 , 8: "qrc:/Journal/BlockNumberedList.qml"
                                 , 9: "qrc:/Journal/BlockEnumList.qml"
                                 })

    width: Window.width - 4*Consts.margin
    height: articleContent.height + downloadContentColumn.height + Consts.margin
    anchors.horizontalCenter: parent.horizontalCenter

    //--------------------------------------------------------------
    // Раскрытый текст
    //--------------------------------------------------------------
    Text {
        id: articleContent

        //text: model.content - выставляется в VisualStatesItem
        width: _additionalContent.width
        opacity: 0.75
        font.pixelSize: Consts.fontNormal
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        textFormat: Text.StyledText
        //horizontalAlignment: Text.AlignJustify
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    } // Text { id: articleContent

    //------------------------------------------------------------------------------
    // Подгружаемые данные
    //------------------------------------------------------------------------------
    Column {
        id: downloadContentColumn

        width: parent.width
        anchors {
            top: articleContent.bottom
            topMargin: 0.3*Window.height
        }

        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }

        spacing: Consts.margin

        // Не ListView, a Repeater, так как выше прокрутка идет через Flickable
        Repeater {
            id: blockRepeater

            // Выставляется в onStopOpenAnimation
            //model: articleBlocksModel.getBlocksModel(index)
            Loader {
                width: parent.width
                source: blockDelegate[model.blockId]
            }
        } //  Repeater {
    } // Column {

    //------------------------------------------------------------------------------
    Connections {
        target: visualStatesItem

        onStopOpenAnimation: {
            Log.vonabirg("onOpenAnimationStop")
            blockRepeater.model = articleBlocksModel.getBlocksModel(index)
            downloadContentColumn.anchors.topMargin = Consts.margin
        }

        onStartHideAnimation: {
            downloadContentColumn.anchors.topMargin = 0.3*Window.height
        }
    } // Connections {
}


