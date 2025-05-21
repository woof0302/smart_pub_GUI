import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 800
    height: 480

    Image {
        id: background
        source: "qrc:images/pub.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop // 화면 비율 맞추기
    }

    Button {
        id: control
        text: qsTr("주문하기")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 12

        width: 100
        height: 36

        background: Rectangle {
            radius: 10
            color: control.down ? "#222222" : "#000000"
            border.color: "#000000"
        }

        contentItem: Text {
            text: control.text
            color: "white"
            font.pixelSize: 14
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
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
