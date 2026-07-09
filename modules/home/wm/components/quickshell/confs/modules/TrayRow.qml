import QtQuick
import Quickshell.Services.SystemTray

Row {
    id: trayRow
    required property var targetWindow
    readonly property alias count: trayRepeater.count
    visible: count > 0
    spacing: 12

    Repeater {
        id: trayRepeater
        model: SystemTray.items

        delegate: Image {
            required property SystemTrayItem modelData
            source: modelData.icon
            sourceSize.width: 16
            sourceSize.height: 16
            width: 16
            height: 16
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            smooth: true

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton && !modelData.onlyMenu) {
                        modelData.activate();
                    } else {
                        modelData.display(trayRow.targetWindow, mouse.x, mouse.y);
                    }
                }
            }
        }
    }
}
