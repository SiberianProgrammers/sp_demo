import QtQuick 2.8

import "../"

//--------------------------------------------------------------------------
ListView {
    id: journalView

    model: journalModel
    delegate: JournalDelegate {}
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        topMargin: actionBar.height
    }

    spacing: Consts.marginBig
    boundsBehavior: Flickable.StopAtBounds

    //TODO
    // После прокрутки сделать внизу кнопку связаться с нами
} // ListView {
