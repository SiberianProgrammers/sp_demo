import QtQuick 2.8
import SP 1.0

import "../"

Column {
    id: _previewContent

    readonly property alias articleImage: articleImage
    readonly property alias articleHeader: articleHeader

    width: parent.width
    spacing: parent.spacing

    //--------------------------------------------------------------
    // Картинка новости
    //--------------------------------------------------------------------------
    ImageParallax {
        id: articleImage

        source: model.imageSource //"qrc:/Journal/trump.png"
        width: parent.width
        height: 0.4*Window.height
        delegate: _journalDelegate
        relativeItem: journalView
        anchors.horizontalCenter: parent.horizontalCenter
    } // ImageParallax {

    //--------------------------------------------------------------
    // Заголовок
    //--------------------------------------------------------------
    Text {
        id: articleHeader

        text: model.caption
        width: Window.width - 4*Consts.margin
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        font {
            pixelSize: 1.2*Consts.fontNormal
            bold: true
        }
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        opacity: 0.75
    } // Text {
}
