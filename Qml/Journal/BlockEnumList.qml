import QtQuick 2.8
import "../"
import "qrc:/SpQml"
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
            //leftMargin: Consts.margin
        }
        spacing: Consts.spacing

        //------------------------------------------------------------------------------
        Repeater {
            model: numberedModel.length

            Row {
                spacing: Consts.margin

                //------------------------------------------------------------------------------
                Rectangle {
                    width: mm
                    height: width
                    radius: width/2
                    color: "black"
                    opacity: 0.75
                    anchors {
                        top: parent.top
                        topMargin: 0.5*(Consts.fontMetricsNormal.height - mm)
                    }
                }

                //------------------------------------------------------------------------------
                Text {
                    width: column.width - mm - Consts.margin
                    text: numberedModel[index]
                    opacity: 0.75
                    font.pixelSize: Consts.fontNormal
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                } // Text {
            } // Row {
        } // Repeater {
    } // Column {
}
