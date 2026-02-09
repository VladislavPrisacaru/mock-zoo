import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls.Material 2.15

Button {
    property string btnText: ""

    text: btnText

    Layout.preferredHeight: 80
    Layout.preferredWidth: 200

    Material.background: '#ffffff'

    font.pixelSize: 13 * uiScale
}