// Booking.qml

import QtQuick 
import QtQuick.Controls
import QtQuick.Controls.Calendar
import QtQuick.Dialogs 
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

        TextField {
    id: dateField
    readOnly: true
    placeholderText: "Select tour date"

    TapHandler {
        onTapped: popup.open()
    }
}

Popup {
    id: popup
    modal: true
    focus: true
    anchors.centerIn: parent
    width: 320
    height: 300

    Calendar {
        anchors.fill: parent

        onClicked: function(date) {
            dateField.text = Qt.formatDate(date, "dd MMM yyyy")
            popup.close()
        }
    }
}
    }
}
