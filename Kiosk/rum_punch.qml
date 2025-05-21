import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 800
    height: 480

    property string selectedMenu: "rum_punch"

    ListModel {
        id: quantityModel
        ListElement { name: "샷1"; quantity: 1 }
        ListElement { name: "샷2"; quantity: 1 }
        //ListElement { name: "얼음"; quantity: 1 }
    }

    Row {
        anchors.fill: parent
        spacing: 40
        padding: 16

        Column {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: menuImage
                source: "images/rum_punch.png"
                width: 280
                height: 280
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -16
            }

            Text {
                text: "Rum Punch"
                font.pixelSize: 26
                font.bold: true
                color: "#222222"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            spacing: 16
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: quantityModel
                delegate: Row {
                    spacing: 8
                    height: 48

                    Text {
                        text: model.name
                        width: 60
                        font.pixelSize: 20
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "-"
                        width: 50
                        onClicked: {
                            if (model.quantity > 1)
                                quantityModel.setProperty(index, "quantity", model.quantity - 1)
                        }
                    }

                    Text {
                        text: model.quantity
                        width: 30
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "+"
                        width: 50
                        onClicked: {
                            if (model.quantity < 5)
                                quantityModel.setProperty(index, "quantity", model.quantity + 1)
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 60

                Button {
                    text: "주문담기"
                    width: 120
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
}
