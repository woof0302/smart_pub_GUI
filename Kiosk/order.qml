import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 640
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
            height: 200
            color: "#fdf6ec"


            Row {
                spacing: 150
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                Image {
                    source: image
                    width: 200
                    height: 200
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    text: name
                    font.pixelSize: 30
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: image.right
                    anchors.leftMargin: 100
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // console.log("선택한 메뉴:", name)
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

        width: 70
        height: 70
        radius: 12
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
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
