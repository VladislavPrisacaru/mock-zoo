import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls.Material 2.15

//Main.qml

ApplicationWindow {
    id: mainWindow
    visible: true

    width: Screen.width    // full screen width
    height: Screen.height
    visibility: Window.Maximized

    property real fontScale: mainWindow.width / 1920
    property real uiScale: Math.max(1.0, mainWindow.width / 1600)

    property int fontSmall: 13
    property int fontMedium: 16
    property int fontLarge: 22
    property int fontXL: 30

    Item {
        anchors.fill: parent

        NavBar { 
            id: navbar
            anchors.top: parent.top
        }

        StackView {
            id: stack

            anchors.top: navbar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            initialItem: HomePage{}
        }

        Connections {
            target: navbar
            ignoreUnknownSignals: true

            function onGoToLogin() {
                stack.push(Qt.resolvedUrl("LogIn.qml"))
            }

            function onGoToProfile() {
                stack.push(Qt.resolvedUrl("Profile.qml"))
            }

            function onGoHome () {
                stack.pop(null)                
            }

            function onGoToBooking() {
                stack.push(Qt.resolvedUrl("Booking.qml"))
            }
        }

        Connections {
            target: stack.currentItem
            ignoreUnknownSignals: true

            function onGoToRegister() {
                stack.push(Qt.resolvedUrl("Register.qml"))
            }

            function onGoToLogin() {
                stack.pop()
            }

            function onGoToProfile() {
                stack.push(Qt.resolvedUrl("Profile.qml"))
            }

            function onGoHome () {
                stack.pop(null)                
            }

        }
    }
}