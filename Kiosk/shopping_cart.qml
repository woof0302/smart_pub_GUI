import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import TcpComm 1.0

Item {
    width: 1200
    height: 960

    ListView {
        anchors.fill: parent
        model: CartModel
        spacing: 20
        clip: true

        delegate: Rectangle {
            width: parent.width
            height: 360
            color: "#f4f4f4"
            radius: 12
            border.color: "#cccccc"
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 30

                Image {
                    source: "images/" + menu.toLowerCase().replace(" ", "_") + ".png"
                    Layout.preferredWidth: 260
                    Layout.preferredHeight: 260
                    fillMode: Image.PreserveAspectFit
                }

                ColumnLayout {
                    spacing: 12
                    Layout.fillWidth: true

                    Text { text: "메뉴: " + menu; font.pixelSize: 32 }
                    Text { text: "얼음: " + option1; font.pixelSize: 28 }
                    Text { text: "시럽: " + option2; font.pixelSize: 28 }
                    Text { text: "레몬: " + option3; font.pixelSize: 28 }

                    RowLayout {
                        spacing: 20

                        Button {
                            text: "-"
                            onClicked: {
                                if (quantity > 1)
                                    CartModel.updateQuantity(index, quantity - 1)
                            }
                        }

                        Text {
                            text: quantity.toString()
                            font.pixelSize: 32
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Button {
                            text: "+"
                            onClicked:
                                if(quantity < 10){
                                    CartModel.updateQuantity(index, quantity + 1)
                                }
                        }
                    }
                }

                // ✕ 삭제 버튼
                Rectangle {
                    width: 80
                    height: 80
                    color: "#ff3b30"
                    radius: 20
                    Layout.alignment: Qt.AlignVCenter
                    // anchors.verticalCenter: parent.verticalCenter


                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("❌ X 버튼 클릭됨")
                            CartModel.removeItem(index)
                        }
                    }

                    Text {
                        text: "✕"
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 44
                        font.bold: true
                    }
                }
            }
        }
    }


    Button {
        id: backButton
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 40
        background: Rectangle {
            radius: 12
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

    Button {
        id: payButton
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 40
        background: Rectangle {
            radius: 12
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
