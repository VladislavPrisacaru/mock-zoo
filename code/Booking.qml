// LogIn.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls.Material 2.15
import "Components" as UI

Item {

    signal goToRegister()
    signal goToLogin()
    signal goToProfile()

    UI.FormFrame {
        anchors.centerIn: parent
        
        Label { text: "Label" }

   }
}
