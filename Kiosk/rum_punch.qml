import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 1024
    height: 768

    property string selectedMenu: "rum_punch"

    ListModel {
        id: quantityModel
        ListElement { name: "샷"; quantity: 1 }
        ListElement { name: "시럽"; quantity: 1 }
        ListElement { name: "얼음"; quantity: 1 }
    }

    Row {
        anchors.fill: parent
        spacing: 80
        padding: 32

        Column {
            spacing: 16
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: menuImage
                source: "images/rum_punch.png"
                width: 460
                height: 460
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -32
            }

            Text {
                text: "Rum Punch"
                font.pixelSize: 36
                font.bold: true
                color: "#222222"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            spacing: 32
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: quantityModel
                delegate: Row {
                    spacing: 16
                    height: 64

                    Text {
                        text: model.name
                        width: 80
                        font.pixelSize: 26
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "-"
                        width: 80
                        onClicked: {
                            if (model.quantity > 1)
                                quantityModel.setProperty(index, "quantity", model.quantity - 1)
                        }
                    }

                    Text {
                        text: model.quantity
                        width: 50
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "+"
                        width: 80
                        onClicked: {
                            if (model.quantity < 5)
                                quantityModel.setProperty(index, "quantity", model.quantity + 1)
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 80

                Button {
                    text: "주문담기"
                    width: 160
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        var quantities = []
                        for (var i = 0; i < quantityModel.count; ++i) {
                            quantities.push(quantityModel.get(i).quantity)
                        }

                        CartModel.addItem(selectedMenu, 1, quantities)

                        var stack = parent
                        while (stack && !stack.replace) stack = stack.parent
                        if (stack) {
                            stack.replace("qrc:/order.qml")
                        }
                    }
                }
            }
        }
    }

    Button {
        id: backButton
        width: 80
        height: 80
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 32
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
}
