import QtQuick 2.8
import "../"

//------------------------------------------------------------------------------
// Список-перечисление
//------------------------------------------------------------------------------
Item {
    id: _blockEnumList

    property var numberedModel: model.blockData
    width: parent.width
    height: column.height

    //------------------------------------------------------------------------------
    Column {
        id: column

        anchors {
            left: parent.left
            right: parent.right
            leftMargin: Consts.margin
        }
        spacing: Consts.spacing

        //------------------------------------------------------------------------------
        Repeater {
            model: numberedModel.length

            Row {
                spacing: Consts.margin

                //------------------------------------------------------------------------------
                Rectangle {
                    width: 1.5*mm
                    height: width
                    radius: width/2
                    color: "black"
                    opacity: 0.75
                    anchors.verticalCenter: parent.verticalCenter
                }

                //------------------------------------------------------------------------------
                Text {
                    width: column.width - 1.5*mm - Consts.margin
                    text: numberedModel[index]
                    opacity: 0.75
                    font.pixelSize: Consts.fontNormal
                    elide: Text.ElideRight
                } // Text {
            } // Row {
        } // Repeater {
    } // Column {
}
