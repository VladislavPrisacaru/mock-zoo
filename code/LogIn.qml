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

    property string errorMessage: ""

    ColumnLayout {
        anchors.centerIn: parent

        Frame {

            Layout.fillWidth: true

            Material.elevation: 3
            padding: 30
            topPadding: 30
            bottomPadding: 30
            Material.roundedScale: Material.LargeScale


            ColumnLayout {

                Layout.fillWidth: true
                spacing: 15
                
                Label {
                    text: errorMessage
                    color: "red"
                    visible: errorMessage !== ""
                    font.pixelSize: 13 * uiScale
                }

                Label { text: "Log In"; font.pixelSize: 13 * uiScale }

                UI.InputRow { id: emailRow; labelText: "Email:" }
                UI.InputRow { id: passwordRow; labelText: "Password:"; isPassword: true }

                Item {Layout.fillHeight: true}

                RowLayout {

                    spacing: 30

                    UI.AppButton {

                        btnText: "Register"
                        Layout.fillWidth: true
                        onClicked: {
                            goToRegister()
                            clearFields()
                        }
                    }

                    UI.AppButton {

                        btnText: "Log In"
                        Layout.fillWidth: true
                        onClicked: handleLogin()
                        
                    }
                }
            }
        }
    }

    function handleLogin() {
        try {
            if (!emailRow.inputText || !passwordRow.inputText) {
                console.log("All fields are required.");
                errorMessage = "All fields are required"
                return;
            }

            if (backend.logIn(emailRow.inputText, passwordRow.inputText)) {
                console.log("going profile")
                goToProfile()
                errorMessage = ""
                clearFields()

            } else {
                console.log("login failed")
                errorMessage = "email or password are wrong"
            }

        } catch (err) {
            console.log(err)
        }
    }

    function clearFields() {
        emailRow.inputText = "" 
        passwordRow.inputText = ""
    }
}