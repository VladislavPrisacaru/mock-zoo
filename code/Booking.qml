// Booking.qml

import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 
import QtQuick.Controls.Material 
import "Components" as UI

Item {

    signal goToRegister()
    signal goToLogin()
    signal goToProfile()

    UI.FormFrame {
        anchors.centerIn: parent

        
        Label { text: "Choose your tour date" }

        DateEdit {}
    }
}
