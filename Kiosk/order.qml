import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 800
    height: 480

    property var cartModelRef

    ListView {
        id: menuList
        width: parent.width
        height: parent.height
        model: menuModel
        delegate: menuItemDelegate
        spacing: 10
        orientation: ListView.Vertical
        clip: true
    }

    ListModel {
        id: menuModel
        ListElement { name: "Blue Lagoon"; image: "images/blue_lagoon.png" }
        ListElement { name: "Magarita"; image: "images/magarita.png" }
        ListElement { name: "Mojito"; image: "images/mojito.png" }
        ListElement { name: "Negroni"; image: "images/negroni.png" }
        ListElement { name: "Rum Punch"; image: "images/rum_punch.png" }
    }

    Component {
        id: menuItemDelegate

        Rectangle {
            width: menuList.width
            height: 180
            color: "#fdf6ec"

            Row {
                spacing: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 16

                Image {
                    source: image
                    width: 120
                    height: 120
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    text: name
                    font.pixelSize: 22
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var stack = parent
                    while (stack && !stack.replace) stack = stack.parent
                    if (stack) {
                        if (name === "Blue Lagoon") stack.push("qrc:/blue_lagoon.qml")
                        else if (name === "Magarita") stack.push("qrc:/magarita.qml")
                        else if (name === "Mojito") stack.push("qrc:/mojito.qml")
                        else if (name === "Negroni") stack.push("qrc:/negroni.qml")
                        else if (name === "Rum Punch") stack.push("qrc:/rum_punch.qml")
                    }
                }
            }
        }
    }

    Rectangle {
        width: 64
        height: 64
        radius: 12
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        color: "transparent"

        Image {
            anchors.fill: parent
            source: "qrc:/images/cart.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var stack = parent
                while (stack && !stack.replace) stack = stack.parent
                if (stack) {
                    stack.replace("qrc:/shopping_cart.qml")
                }
            }
        }
    }
}
