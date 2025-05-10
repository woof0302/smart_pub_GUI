import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 640
    height: 480

//    Image {
//        id: background
//        source: "qrc: 사진경로"
//        anchors.fill: parent
//        fillMode: Image.PreserveAspectCrop
//    }

    Button {
        text: "주문하기"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30

        background: Rectangle {
                radius: 12   // 원하는 둥글기 정도로 조절
                color: control.down ? "#777777" : "#999999"
                border.color: "#666666"
        }

        onClicked: {
            var stack = parent
            while (stack && !stack.replace) stack = stack.parent
            if (stack) {
                stack.replace("qrc:/menu.qml")
            }
        }
    }
}
