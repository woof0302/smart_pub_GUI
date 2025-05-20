import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 800
    height: 480

    property string selectedMenu: "magarita"

    ListModel {
        id: quantityModel
        ListElement { name: "샷"; quantity: 1 }
        ListElement { name: "시럽"; quantity: 1 }
        ListElement { name: "얼음"; quantity: 1 }
    }

    Row {
        anchors.fill: parent
        spacing: 50
        padding: 20

        Column{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: menuImage
                source: "images/magarita.png"
                width: 280
                height: 280
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -20
            }

            Text {
                text: "Magarita"
                font.pixelSize: 22
                font.bold: true
                color: "#222222"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            spacing: 20
            anchors.verticalCenter: parent.verticalCenter

            // 커스텀
            Repeater {
                model: quantityModel
                delegate: Row {
                    spacing: 10
                    height: 40

                    Text {
                        text: model.name
                        width: 50
                        font.pixelSize: 16
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
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        text: "+"
                        width: 50
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
                height: 50

                Button {
                    text: "주문담기"
                    width: 100
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

    // 뒤로가기 버튼 (order페이지)

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
}
