import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Экран списка контактов
//--------------------------------------------------------------------------
Item {
    id: _container

    width: profileListView.width
    height: index+1 < profileListView.model.count || photo.height + _profileDelegate.height*profileListView.model.count + nameContainer.height < _profileView.height
            ? _profileDelegate.height
            : Math.max(_profileDelegate.height + _profileView.height - nameContainer.height - Consts.statusBarHeight - Consts.margin - _profileDelegate.height*profileListView.model.count, _profileDelegate.height)

    Item {
        id: _profileDelegate

        width: profileListView.width
        height: Math.ceil(column.height + Consts.margin)

        ImageSp {
            id: icon

            source: model.icon
            height: 4*mm
            width: height
            anchors {
                left: parent.left
                leftMargin: Consts.marginBig
            }
            y: (parent.height - height)/2
        }

        //--------------------------------------------------------------------------
        Column {
            id: column

            anchors {
                left: icon.right
                right: parent.right
                leftMargin: Consts.marginBig
                rightMargin: Consts.margin
                verticalCenter: parent.verticalCenter
            }

            //----------------------------------------------------------------------
            Text {
                text: model.value
                elide: Text.ElideRight
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Consts.fontSmall
                font {
                    pixelSize: Consts.fontNormal
                    weight: Font.Medium
                }
                anchors {
                    left: parent.left
                    right: parent.right
                }
            }

            //----------------------------------------------------------------------
            Text {
                text: model.fieldName
                elide: Text.ElideRight
                font.pixelSize: Consts.fontSmall
                color: Consts.gray
                anchors {
                    left: parent.left
                    right: parent.right
                }
            }
        } // Column {
    }
}
