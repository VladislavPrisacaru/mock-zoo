// Register.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls.Material 2.15
import "Components" as UI

Item {

    signal goToLogin()
    signal goToProfile()

    property string errorMessage: ""

    UI.FormFrame {
        anchors.centerIn: parent

        Label {
            text: errorMessage
            color: "red"
            visible: errorMessage !== ""
            font.pixelSize: 13 * uiScale
        }

        Label { text: "Register"; font.pixelSize: 13 * uiScale }

        UI.InputRow { id: usernameRow; labelText: "Username"}
        UI.InputRow { id: emailRow; labelText: "Email:" }
        UI.InputRow { id: passwordRow; labelText: "Password:"; isPassword: true }
        UI.InputRow { id: confirmRow; labelText: "Confirm Password:"; isPassword: true }

        Item {Layout.fillHeight: true}
        
        RowLayout { 

            spacing: 30

            UI.AppButton { 
                btnText: "Back" 
                Layout.fillWidth: true 
                onClicked: goToLogin()
            } 

            UI.AppButton { 
                btnText: "Register" 
                Layout.fillWidth: true 
                onClicked: handleRegister()
            } 
        }
    }

    function handleRegister() {
        
        try {
        if (!usernameRow.inputText || !emailRow.inputText || !passwordRow.inputText || !confirmRow.inputText) {
            console.log("All fields are required.");
            errorMessage = "All fields are required"
            return;
        }
        
        if (passwordRow.inputText !== confirmRow.inputText) {
            console.log("Passwords do not match.");
            errorMessage = "Passwords do not match"
            return; 
        }

        if (backend.register(usernameRow.inputText, emailRow.inputText, passwordRow.inputText)) {
            if (backend.logIn(emailRow.inputText, passwordRow.inputText)) {
                console.log("going profile")
                goToProfile()
                errorMessage = ""
                clearFields()
            }

        } else { 
            console.log("registration failed") 
            errorMessage = "User already exists"
        }

        } catch (err) {
            console.log(err)
        }      
    }

    function clearFields() {
        usernameRow.inputText = ""
        emailRow.inputText = "" 
        passwordRow.inputText = ""
        confirmRow.inputText = "" 
    }
}

