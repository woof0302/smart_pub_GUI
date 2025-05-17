import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 640
    height: 480

    Rectangle {
        id: menu
        width: parent.width
        height: parent.height
        color: "#ffffff"
        anchors.top: parent.top

        Button {
            width: 120
            height: 40
            text: "회원가입"
            anchors.bottom: parent.bottom

            background: Rectangle {
                anchors.fill: parent
                radius: 12
                color: "#000000"
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                var stack = parent
                while (stack && !stack.replace) stack = stack.parent
                if (stack) {
                    stack.replace("qrc:/join_membership.qml")
                }
            }
        }

        Button {
            width: 120
            height: 40
            x: 130
            text: "로그인"
            anchors.bottom: parent.bottom


            background: Rectangle {
                anchors.fill: parent
                radius: 12
                color: "#000000"
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                var stack = parent
                while (stack && !stack.replace) stack = stack.parent
                if (stack) {
                    stack.replace("qrc:/log_in.qml")
                }
            }
        }

        Button {
            width: 120
            height: 40
            x: 390
            text: "장바구니"
            anchors.bottom: parent.bottom

            background: Rectangle {
                anchors.fill: parent
                radius: 12
                color: "#000000"
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                var stack = parent
                while (stack && !stack.replace) stack = stack.parent
                if (stack) {
                    stack.replace("qrc:/shopping_cart.qml")
                }
            }
        }

        Button {
            width: 120
            height: 40
            x: 520
            text: "결제하기"
            anchors.bottom: parent.bottom

            background: Rectangle {
                anchors.fill: parent
                radius: 12
                color: "#000000"
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 16
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                var stack = parent
                while (stack && !stack.replace) stack = stack.parent
                if (stack) {
                    stack.replace("qrc:/payment.qml")
                }
            }
        }
    }
}
