import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Список контактов
//--------------------------------------------------------------------------
Item {
    id: _contactDelegate

    width: _contactsView.width
    height: Math.ceil(12*mm)

    //------------------------------------------------------------------------
    ImageSp {
        id: avatar

        source: "qrc:/Contacts/Profiles/Avatar0.jpg"
        radius: height/2
        anchors {
            left: parent.left
            leftMargin: Consts.margin
            verticalCenter: parent.verticalCenter
        }
        height: parent.height-Consts.margin
        width: height

        Rectangle {
            anchors {
                fill: parent
                margins: -border.width
            }
            radius: height/2
            color: "transparent"
            border {
                width: Consts.borderWidth
                color: "#55888888"
            }
        }
    }

    //------------------------------------------------------------------------
    Text {
        id: name

        text: "Михаил Серебренников"
        elide: Text.ElideRight
        font.pixelSize: Consts.fontNormal
        anchors {
            left: avatar.right
            right: parent.right
            bottom: parent.verticalCenter
            margins: Consts.margin
            bottomMargin: Consts.spacing/2
        }
    }

    //------------------------------------------------------------------------
    Text {
        id: companyAndPosition

        text: "директор, «Сибирские Программисты»"
        elide: Text.ElideRight
        font.pixelSize: Consts.fontSmall
        color: Consts.gray
        anchors {
            left: avatar.right
            right: parent.right
            top: parent.verticalCenter
            margins: Consts.margin
            topMargin: Consts.spacing/2
        }
    }
}
