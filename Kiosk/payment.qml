import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 1200
    height: 960

    Timer {
        id: paymentTimer
        interval: 3000
        running: true
        repeat: false
        onTriggered: {
            stackView.replace("first_page.qml")
        }
    }

    Image {
        id: cardImage
        source: "qrc:/images/payment.png"
        anchors.centerIn: parent
        width: 900
        height: 600
        fillMode: Image.PreserveAspectFit
    }

    Text {
        text: "결제 중"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        font.pixelSize: 40
        color: "#333"
    }
}
