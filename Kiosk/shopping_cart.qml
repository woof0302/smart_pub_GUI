import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 640
    height: 480

    ListView {
        anchors.fill: parent
        model: CartModel
        spacing: 10
        clip: true

        delegate: Rectangle {
            width: parent.width
            height: 180
            color: "#f4f4f4"
            radius: 8
            border.color: "#cccccc"
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 15

                Image {
                    source: "images/" + menu.toLowerCase().replace(" ", "_") + ".png"
                    Layout.preferredWidth: 130
                    Layout.preferredHeight: 130
                    fillMode: Image.PreserveAspectFit
                }

                ColumnLayout {
                    spacing: 6
                    Layout.fillWidth: true

                    Text { text: "메뉴: " + menu; font.pixelSize: 16 }
                    Text { text: "얼음: " + option1; font.pixelSize: 14 }
                    Text { text: "시럽: " + option2; font.pixelSize: 14 }
                    Text { text: "레몬: " + option3; font.pixelSize: 14 }

                    RowLayout {
                        spacing: 10

                        Button {
                            text: "-"
                            onClicked: {
                                if (quantity > 1)
                                    CartModel.updateQuantity(index, quantity - 1)
                            }
                        }

                        Text {
                            text: quantity.toString()
                            font.pixelSize: 16
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
                    width: 40
                    height: 40
                    color: "#ff3b30"
                    radius: 20
                    Layout.alignment: Qt.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter

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
                        font.pixelSize: 22
                        font.bold: true
                    }
                }
            }
        }
    }


    Button {
        id: backButton
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
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

    Button {
        id: payButton
        width: 50
        height: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
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
            var stack = parent
            while (stack && !stack.replace) stack = stack.parent
            if (stack) {
                stack.replace("qrc:/payment.qml")
            }

        }
    }


}
