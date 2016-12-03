import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Список контактов
//--------------------------------------------------------------------------
ListView {
    id: _contactsView
    
    anchors {
        top: actionBar.bottom
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    model: 20
    delegate: ContactDelegate { }
    maximumFlickVelocity: 8*height
    header: Item {
        width: _contactsView.width
        height: Consts.margin/2
    }
}
