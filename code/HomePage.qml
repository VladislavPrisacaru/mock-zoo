// LogIn.qml

import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
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