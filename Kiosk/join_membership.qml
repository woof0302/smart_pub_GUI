import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Settings 2.15

Item {
    width: 640
    height: 480

    Component.onCompleted: {
        VirtualKeyboardSettings.locale = "en_US"
        console.log("locales available: " + VirtualKeyboardSettings.availableLocales)
    }

    Flickable {
        id: flickable
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: formColumn.implicitHeight
        clip: true

        Column {
            id: formColumn
            width: parent.width
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40

            Text {
                text: "회원가입"
                font.pixelSize: 24
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            Row {
                spacing: 10
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
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
                    placeholderText: "아이디 입력"
                }
            }

            Row {
                spacing: 10
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
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

                Text {
                    text: "비밀번호 확인:"
                    font.pixelSize: 16
                    width: 100
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                TextField {
                    id: passwordConfirmField
                    width: 250
                    height: 40
                    placeholderText: "비밀번호 확인"
                }
            }

            Row {
                spacing: 10
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "이름:"
                    font.pixelSize: 16
                    width: 100
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                TextField {
                    id: nameField
                    width: 250
                    height: 40
                    placeholderText: "이름"

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            flickable.contentY = phoneNumberField.y + 100; // 원하는 만큼 위로
                        }
                    }
                }
            }

            Row {
                spacing: 10
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "전화번호:"
                    font.pixelSize: 16
                    width: 100
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                TextField {
                    id: phoneNumberField
                    width: 250
                    height: 40
                    placeholderText: "전화번호"

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            flickable.contentY = phoneNumberField.y + 100; // 원하는 만큼 위로
                        }
                    }
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
                    text: "회원가입"
                    onClicked: {
                        console.log("회원가입 클릭됨")
                        if(idField.text === "" || passwordField.text === "" || passwordConfirmField.text === ""
                                || nameField.text === "" || phoneNumberField.text === ""){
                            console.log("모든 항목을 입력하세요")
                            return
                        }

                        if(passwordField.text !== passwordConfirmField.text){
                            console.log("PW:", passwordField.text)
                            console.log("PW_CONFIRM:", passwordConfirmField.text)
                            console.log("비밀번호가 일치하지 않습니다")
                            return
                        }

                        backend.checkIdAndRegister(idField.text, passwordField.text, nameField.text, phoneNumberField.text )
                    }
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
