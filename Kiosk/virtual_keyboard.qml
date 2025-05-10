import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Settings 2.15

Item {
    width: 640
    height: 480

    Component.onCompleted: {
        VirtualKeyboardSettings.locale = "en_US"
        console.log("locales available: "+VirtualKeyboardSettings.availableLocales)
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "This is Main Page"
            font.pointSize: 20
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        TextField {
            id: inputField
            width: 400
            height: 40
            font.pointSize: 16
            focus: true
            placeholderText: "Type something..."
        }

        Text {
            text: inputField.text
            font.pointSize: 16
            color: "blue"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }

    InputPanel {
        id: inputPanel
        z: 99
        y: parent.height
        width: parent.width
        visible: Qt.inputMethod.visible
        anchors.bottom: parent.bottom           

        states: State {
            name: "visible"
            when: Qt.inputMethod.visible
            PropertyChanges {
                target: inputPanel
                y: parent.height - inputPanel.height
            }
        }

        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
