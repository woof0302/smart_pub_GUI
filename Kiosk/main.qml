import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 480
    title: "Kiosk"
    visibility: Window.FullScreen
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    // flags: Qt.FramelessWindowHint

    Item {
        anchors.fill: parent
        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Escape) {
                Qt.quit()
            }
        }

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: "qrc:/first_page.qml"
        }
    }
}
