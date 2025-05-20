import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 800
    height: 480

    Image {
        id: background
        source: "qrc:images/pub.png"
        anchors.fill: parent
        fillMode: Image.Stretch //PreserveAspectCrop
    }

    Button {
        id: control
        text: qsTr("주문하기")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 15

        width: 120
        height: 40

        background: Rectangle {
            radius: 12
            color: control.down ? "#222222" : "#000000"
            border.color: "#000000"
        }

        contentItem: Text {
            text: control.text
            color: "white"
            font.pixelSize: 16
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        onClicked: {
            var stack = parent
            while (stack && !stack.replace) stack = stack.parent // stack 이라는 변수에 버튼의 parent부터 시작해서 위로 올라가며 replace()라는 함수를 가진 부모를 찾을 때까지 반복
            if (stack) {                            // 찾으면
                stack.replace("qrc:/order.qml")      // stack.replace("qrc:/shopping_cart.qml") 호출해서 페이지 전환
            }                   // replace() 교체  push() 새 페이지 추가 (기존은 스택 아래로 내려감)   pop() 최근 페이지 제거하고 이전 페이지 복귀
        }
    }

}
