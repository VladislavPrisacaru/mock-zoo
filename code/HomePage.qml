// LogIn.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import "Components" as UI

Item { 

    signal goToLogin

    Rectangle {
        
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent

            Text {text: "home page"}
        }
    }
}