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
        spacing: 20
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            text: "로그인"
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Row{
            spacing: 10
            Text{
                text: "ID:"
                font.pixelSize: 16
                width: 100
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            TextField {
                id: idField
                width: 250
                height: 40
                placeholderText: "ID 입력"
            }
        }

        Row{
            spacing: 10
            Text{
                text: "비밀번호:"
                font.pixelSize: 16
                width: 100
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            TextField {
                id: passwordField
                width: 250
                height: 40
                placeholderText: "비밀번호 입력"
            }
        }

        Row {
            spacing: 10
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            width: 350  // Text(100) + TextField(250) 와 동일

            Rectangle {
                width: 230   // TextField 오른쪽 끝 - 버튼 너비 (250 - 120 = 130) + Text(100) = 230
                height: 1
                color: "transparent"
            }

            Button {
                width: 120
                height: 40
                text: "로그인"
                onClicked: {
                    console.log("로그인 클릭됨")
                }
            }
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
