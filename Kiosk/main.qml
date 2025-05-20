import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 1200
    height: 960
    title: "Kiosk"
    // visibility: Window.FullScreen
    // flags: Qt.FramelessWindowHint 타이틀 바 없이 실행

    Item {
        anchors.fill: parent
        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Escape) {
                Qt.quit()
            }
        }

        StackView {         // 화면 전환 내장 QML 타입
            id: stackView
            anchors.fill: parent
            initialItem: "qrc:/first_page.qml"   // 첫 페이지는 여기서 시작
        }

    }
}
