import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Kiosk"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/first_page.qml"   // 첫 페이지는 여기서 시작
    }
}
