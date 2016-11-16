import QtQuick 2.7

import "../"

//--------------------------------------------------------------------------
ListView {
    id: journalView

    model: journalModel
    delegate: JournalDelegate {}

    anchors {
        top: actionBar.bottom
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    clip: true
    spacing: Consts.marginBig
    boundsBehavior: Flickable.StopAtBounds

    header: Item {
        width: parent.width
        height: Consts.margin
    }

    //TODO
    // После прокрутки сделать внизу кнопку связаться с нами
} // ListView {
