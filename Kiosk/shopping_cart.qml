import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import TcpComm 1.0

Item {
    width: 800
    height: 480

    ListView {
        anchors.fill: parent
        model: CartModel
        spacing: 10
        clip: true

        delegate: Rectangle {
            width: parent.width
            height: 160
            color: "#f4f4f4"
            radius: 12
            border.color: "#cccccc"
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 12

                Image {
                    source: "images/" + menu.toLowerCase().replace(" ", "_") + ".png"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    fillMode: Image.PreserveAspectFit
                }

                ColumnLayout {
                    spacing: 4
                    Layout.fillWidth: true

                    Text { text: "메뉴: " + menu; font.pixelSize: 20 }
                    Text { text: "얼음: " + option1; font.pixelSize: 18 }
                    Text { text: "시럽: " + option2; font.pixelSize: 18 }
                    Text { text: "레몬: " + option3; font.pixelSize: 18 }

                    RowLayout {
                        spacing: 8

                        Button {
                            text: "-"
                            Layout.preferredWidth: 50
                                Layout.preferredHeight: 25
                            onClicked: {
                                if (quantity > 1)
                                    CartModel.updateQuantity(index, quantity - 1)
                            }
                        }

                        Text {
                            text: quantity.toString()
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Button {
                            text: "+"
                            Layout.preferredWidth: 50
                                Layout.preferredHeight: 25
                            onClicked: {
                                if(quantity < 10){
                                    CartModel.updateQuantity(index, quantity + 1)
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: 48
                    height: 48
                    color: "#ff3b30"
                    radius: 12
                    Layout.alignment: Qt.AlignVCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            CartModel.removeItem(index)
                        }
                    }

                    Text {
                        text: "✕"
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 24
                        font.bold: true
                    }
                }
            }
        }
    }

    // 뒤로가기 버튼
    Button {
        id: backButton
        width: 60
        height: 60
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 16
        background: Rectangle {
            radius: 10
            color: "transparent"
        }

        contentItem: Image {
            source: "images/back.png"
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }

        onClicked: {
            var stack = parent
            while (stack && !stack.replace) stack = stack.parent
            if (stack) {
                stack.replace("qrc:/order.qml")
            }
        }
    }

    TcpSender {
        id: tcpSender
    }

    // 결제 버튼
    Button {
        id: payButton
        width: 60
        height: 60
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        background: Rectangle {
            radius: 10
            color: "transparent"
        }

        contentItem: Image {
            source: "images/pay.png"
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }

        onClicked: {
            CartModel.sendAllItemsToServer()

            var stack = parent
            while (stack && !stack.replace) stack = stack.parent
            if (stack) {
                stack.replace("qrc:/payment.qml")
            }
        }
    }
}



//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Layouts 1.15
//import TcpComm 1.0

//Item {
//    width: 1024
//    height: 768

//    ListView {
//        anchors.fill: parent
//        model: CartModel
//        spacing: 16
//        clip: true

//        delegate: Rectangle {
//            width: parent.width
//            height: 280
//            color: "#f4f4f4"
//            radius: 12
//            border.color: "#cccccc"
//            border.width: 1
//            anchors.horizontalCenter: parent.horizontalCenter

//            RowLayout {
//                anchors.fill: parent
//                anchors.margins: 16
//                spacing: 20

//                Image {
//                    source: "images/" + menu.toLowerCase().replace(" ", "_") + ".png"
//                    Layout.preferredWidth: 200
//                    Layout.preferredHeight: 200
//                    fillMode: Image.PreserveAspectFit
//                }

//                ColumnLayout {
//                    spacing: 8
//                    Layout.fillWidth: true

//                    Text { text: "메뉴: " + menu; font.pixelSize: 28 }
//                    Text { text: "얼음: " + option1; font.pixelSize: 24 }
//                    Text { text: "시럽: " + option2; font.pixelSize: 24 }
//                    Text { text: "레몬: " + option3; font.pixelSize: 24 }

//                    RowLayout {
//                        spacing: 16

//                        Button {
//                            text: "-"
//                            onClicked: {
//                                if (quantity > 1)
//                                    CartModel.updateQuantity(index, quantity - 1)
//                            }
//                        }

//                        Text {
//                            text: quantity.toString()
//                            font.pixelSize: 28
//                            horizontalAlignment: Text.AlignHCenter
//                            verticalAlignment: Text.AlignVCenter
//                        }

//                        Button {
//                            text: "+"
//                            onClicked:
//                                if(quantity < 10){
//                                    CartModel.updateQuantity(index, quantity + 1)
//                                }
//                        }
//                    }
//                }

//                // 주문 빼기 버튼
//                Rectangle {
//                    width: 64
//                    height: 64
//                    color: "#ff3b30"
//                    radius: 16
//                    Layout.alignment: Qt.AlignVCenter

//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: {
//                            CartModel.removeItem(index)
//                        }
//                    }

//                    Text {
//                        text: "✕"
//                        anchors.centerIn: parent
//                        color: "white"
//                        font.pixelSize: 36
//                        font.bold: true
//                    }
//                }
//            }
//        }
//    }

//    // 뒤로가기 버튼
//    Button {
//        id: backButton
//        width: 80
//        height: 80
//        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        anchors.margins: 32
//        background: Rectangle {
//            radius: 10
//            color: "transparent"
//        }

//        contentItem: Image {
//            source: "images/back.png"
//            fillMode: Image.PreserveAspectFit
//            anchors.fill: parent
//        }

//        onClicked: {
//            var stack = parent
//            while (stack && !stack.replace) stack = stack.parent
//            if (stack) {
//                stack.replace("qrc:/order.qml")
//            }
//        }
//    }

//    TcpSender {
//        id: tcpSender
//    }

//    // 결제 버튼
//    Button {
//        id: payButton
//        width: 80
//        height: 80
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.margins: 32
//        background: Rectangle {
//            radius: 10
//            color: "transparent"
//        }

//        contentItem: Image {
//            source: "images/pay.png"
//            fillMode: Image.PreserveAspectFit
//            anchors.fill: parent
//        }

//        onClicked: {
//            CartModel.sendAllItemsToServer()

//            var stack = parent
//            while (stack && !stack.replace) stack = stack.parent
//            if (stack) {
//                stack.replace("qrc:/payment.qml")
//            }
//        }
//    }
//}
