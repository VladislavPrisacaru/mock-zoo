// formFrame

import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
import QtQuick.Controls.Material 


ColumnLayout {
    id: root
    //anchors.centerIn: parent

    default property alias content: innerColumn.children

    Frame {

        Layout.fillWidth: true

        Material.elevation: 3
        padding: 30
        topPadding: 30
        bottomPadding: 30
        Material.roundedScale: Material.LargeScale


        ColumnLayout {
            id: innerColumn

            Layout.fillWidth: true
            spacing: 20
        }
    }
}

