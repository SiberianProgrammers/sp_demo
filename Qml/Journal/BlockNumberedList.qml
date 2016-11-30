import QtQuick 2.8
import "../"

Item {
    id: _blockNumberedList

    property var numberedModel: model.blockData
    width: parent.width
    height: column.height

    //------------------------------------------------------------------------------
    Column {
        id: column

        anchors {
            left: parent.left
            right: parent.right
            leftMargin: Consts.spacing
        }
        spacing: Consts.spacing

        //------------------------------------------------------------------------------
        Repeater {
            model: numberedModel.length

            Row {
                spacing: Consts.margin

                //------------------------------------------------------------------------------
                Text {
                    id: numberText
                    text: (index+1) + ") "
                    opacity: 0.75
                    font.pixelSize: Consts.fontNormal
                }

                //------------------------------------------------------------------------------
                Text {
                    width: column.width - numberText.width - Consts.margin
                    text:  numberedModel[index]
                    opacity: 0.75
                    font.pixelSize: Consts.fontNormal
                    elide: Text.ElideRight
                } // Text {
            } // Row {
        } // Repeater {
    } // Column {
}
