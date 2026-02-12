// formFrame

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls.Material 2.15


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

