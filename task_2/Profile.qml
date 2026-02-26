// Profile.qml

import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 
import QtQuick.Controls.Material 
import "Components" as UI

Item {

    signal goHome()
    
    ColumnLayout {
        anchors.fill: parent

        Frame{

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: parent.width * 0.1
            Layout.rightMargin: parent.width * 0.1

            padding: 32
            Material.elevation: 4

            Material.roundedScale: Material.NotRounded

            ColumnLayout {

                //Layout.fillWidth: true
                spacing: 15

                Label { text: "Profile"; font.pixelSize: 13 * uiScale }

                Label { text: "username: " + backend.username; font.pixelSize: 13 * uiScale }
                Label { text: "email: " + backend.email; font.pixelSize: 13 * uiScale }

                UI.AppButton {
                    btnText: "Log Out"
                    onClicked: {
                        backend.logOut()
                        goHome()
                    }
                }
            }
        }
    }
}