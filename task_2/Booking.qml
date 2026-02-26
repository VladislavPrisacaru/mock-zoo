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
        property date selectedDate
        anchors.centerIn: parent

        
        Label { text: "Choose your tour date" }

        TextField {
            id: dateInput
            placeholderText: "DD/MM/YYYY"

            validator: RegularExpressionValidator {
                regularExpression: /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/
            }

            onEditingFinished: {
                var parts = text.split("/")
                selectedDate = new Date(parts[2], parts[1]-1, parts[0])
                console.log("Selected:", selectedDate)
            }
        }

        ButtonGroup {
            id: dateGroup
        }

        RadioButton {
            text: "11:00"
            checked: true
            ButtonGroup.group: dateGroup
        }

        RadioButton {
            text: "14:00"
            checked: true
            ButtonGroup.group: dateGroup
        }
    }
}
