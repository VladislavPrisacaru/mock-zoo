// NavBar.qml

import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 
import "Components" as UI

Item { 

    signal goToRegister()
    signal goToLogin()
    signal goToProfile()
    signal goToBooking()
    signal goHome()

    height: parent.height * 0.1
    width: parent.width

    Rectangle {
        anchors.fill: parent

        color: "green" //"#323c61"

        RowLayout {
            id: navbar

            anchors.fill: parent
            spacing: parent.width * 0.012
            anchors.margins: parent.width * 0.005
            anchors.rightMargin: parent.width * 0.015
            anchors.leftMargin: parent.width * 0.01

            Image {
                Layout.fillHeight: true  
                Layout.alignment: Qt.AlignVCenter
                source: "Images/RAZLogoWhite.png"
                Layout.preferredHeight: 130
                Layout.preferredWidth: 85
            }

            Item { Layout.fillWidth: true}

            UI.AppButton {
                btnText: "Home"
                font.pixelSize: mainWindow.fontMedium
                onClicked: goHome()
            }

            UI.AppButton {
                btnText: "Bookings"
                font.pixelSize: mainWindow.fontMedium
                onClicked: goToBooking()
            }

            UI.AppButton {
                btnText: backend.loggedIn ? "Profile" : "Log In"
                font.pixelSize: mainWindow.fontMedium
                onClicked:  backend.loggedIn ? goToProfile() : goToLogin()
            }
        }
    }
}