import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 

RowLayout {
                
    spacing: 10

    property alias labelText: label.text
    property alias inputText: textField.text
    property bool isPassword: false

    Label { 
        id: label
        Layout.preferredWidth: 200
        font.pixelSize: 13 * uiScale
    }

    TextField {
        id: textField 
        Layout.fillWidth: true 
        font.pixelSize: 13 * uiScale
        echoMode: isPassword ? TextInput.Password : TextInput.Normal
    }
}