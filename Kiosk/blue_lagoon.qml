import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 640
    height: 480

    property string selectedMenu: "blue_lagoon"

    ListModel {
        id: quantityModel
        ListElement { name: "얼음"; quantity: 1 }
        ListElement { name: "시럽"; quantity: 1 }
        ListElement { name: "레몬"; quantity: 1 }
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
                source: "images/blue_lagoon.png"
                width: 280
                height: 280
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -20
            }

            Text {
                text: "Blue Lagoon"
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

            // 옵션 조절 영역
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
                            if (model.quantity > 0)
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

            // 주문 담기 버튼 (오른쪽 정렬)
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
                        console.log("메뉴:", selectedMenu)
                        console.log("옵션 수량:", quantities)
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
}
