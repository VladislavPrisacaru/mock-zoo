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
    signal goHome()

    UI.FormFrame {
        property date selectedDate
        anchors.centerIn: parent


        
        Label { text: "Choose your tour date"; font.pixelSize: 13 * uiScale; Layout.fillWidth: true }

        TextField {
            id: dateInput
            Layout.fillWidth: true
            placeholderText: "DD/MM/YYYY"

            validator: RegularExpressionValidator {
                regularExpression: /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/
            }

            onEditingFinished: {
                var parts = text.split("/")
                selectedDate = new Date(parts[2], parts[1]-1, parts[0])
                console.log("Selected:", selectedDate)
            }

            font.pixelSize: 13 * uiScale
        }

        Label { text: "Choose your tour time"; font.pixelSize: 13 * uiScale; Layout.fillWidth: true }

        RowLayout {
            Layout.fillWidth: true
            RadioButton {
                id: earlyTime
                Layout.fillWidth: true
                text: "11:00"
                checked: true
                font.pixelSize: 13 * uiScale
            }

            RadioButton {
                id: lateTime
                Layout.fillWidth: true
                text: "14:00"
                font.pixelSize: 13 * uiScale
            }
        }

        RowLayout {

            spacing: 20

            ColumnLayout {

                Label { text: "Choose number of adults"; font.pixelSize: 13 * uiScale; Layout.fillWidth: true }

                ComboBox {
                    id: adults
                    Layout.fillWidth: true

                    model: ["1","2","3","4","5","6","7","8","9","10"]
                }
            }

            ColumnLayout {

                Label { text: "Choose number of children"; font.pixelSize: 13 * uiScale; Layout.fillWidth: true }

                ComboBox {
                    id: children
                    Layout.fillWidth: true

                    model: ["0","1","2","3","4","5","6","7","8","9","10"]
                }
            }
        }

        Label { text: "Would you like to book a hotel"; font.pixelSize: 13 * uiScale; Layout.fillWidth: true }

        RowLayout {
            Layout.fillWidth: true
            RadioButton {
                id: noHotel
                Layout.fillWidth: true
                text: "no"
                checked: true
                font.pixelSize: 13 * uiScale
            }

            RadioButton {
                id: yesHotel
                Layout.fillWidth: true
                text: "yes"
                font.pixelSize: 13 * uiScale
            }
        }

        Label { 
            text: "Choose number of rooms"; 
            font.pixelSize: 13 * uiScale; 
            Layout.fillWidth: true 
            visible: yesHotel.checked
        }

        ComboBox {
            id: numRooms
            Layout.fillWidth: true

            model: ["0","1","2","3","4","5"]
            visible: yesHotel.checked
        }

        Label { 
            text: "Choose number of rooms"; 
            font.pixelSize: 13 * uiScale; 
            Layout.fillWidth: true 
            visible: yesHotel.checked
        }

        ComboBox {
            id: numNights
            Layout.fillWidth: true

            model: ["0","1","2","3","4","5"]
            visible: yesHotel.checked
        }

        RowLayout {

            spacing: 20

            UI.AppButton {
                Layout.fillWidth: true 
                text: "Cancel"
                onClicked: goHome()
            }

            UI.AppButton {
                Layout.fillWidth: true 
                text: "Confirm"
                
            }
        }
    }
}
