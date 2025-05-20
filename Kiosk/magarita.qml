import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 1200
    height: 960

    property string selectedMenu: "magarita"

    ListModel {
        id: quantityModel
        ListElement { name: "샷"; quantity: 1 }
        ListElement { name: "시럽"; quantity: 1 }
        ListElement { name: "얼음"; quantity: 1 }
    }

    Row {
        anchors.fill: parent
        spacing: 100
        padding: 40

        Column {
            spacing: 20
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: menuImage
                source: "images/magarita.png"
                width: 560
                height: 560
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -40
            }

            Text {
                text: "Magarita"
                font.pixelSize: 44
                font.bold: true
                color: "#222222"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            spacing: 40
            anchors.verticalCenter: parent.verticalCenter

            // 커스텀 옵션 조절
            Repeater {
                model: quantityModel
                delegate: Row {
                    spacing: 20
                    height: 80

                    Text {
                        text: model.name
                        width: 100
                        font.pixelSize: 32
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "-"
                        width: 100
                        onClicked: {
                            if (model.quantity > 1)
                                quantityModel.setProperty(index, "quantity", model.quantity - 1)
                        }
                    }

                    Text {
                        text: model.quantity
                        width: 60
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 28
                    }

                    Button {
                        text: "+"
                        width: 100
                        onClicked: {
                            if(model.quantity < 5)
                                quantityModel.setProperty(index, "quantity", model.quantity + 1)
                        }
                    }
                }
            }

            // 주문 담기 버튼
            Item {
                width: parent.width
                height: 100

                Button {
                    text: "주문담기"
                    width: 200
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

    // 뒤로가기 버튼
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
}
