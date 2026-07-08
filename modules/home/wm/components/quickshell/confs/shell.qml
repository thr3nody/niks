//@ pragma UseQApplication

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray

PanelWindow {
    id: island

    property int revealTriggerHeightt: 6
    property int revealTriggerWidth: 220
    property int pillWidth: 360
    property int pillHeight: 45
    property int topPadding: 10
    property int hideDelayMs: 500
    property string fontFam: "JetBrainsMono Nerd Font"

    // `ls /sys/class/backlight/`
    property string backlightDevice: "amdgpu_bl1"

    property bool revealed: false

    screen: Quickshell.screens[0]

    anchors {
        top: true
        left: true
    }

    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    implicitWidth: pillWidth
    implicitHeight: topPadding + pillHeight
    margins.left: Math.round((screen.width - pillWidth) / 2)

    mask: Region {
        item: hoverArea
    }

    Item {
        id: hoverArea
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: island.revealed ? island.pillWidth : island.revealTriggerWidth
        height: island.revealed ? (island.topPadding + island.pillHeight) : island.revealTriggerHeightt
    }

    MouseArea {
        anchors.fill: hoverArea
        hoverEnabled: true
        onEntered: {
            hideTimer.stop();
            island.revealed = true;
        }
        onExited: hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: island.hideDelayMs
        onTriggered: island.revealed = false
    }

    Rectangle {
        id: pillContainer
        width: island.pillWidth
        height: island.pillHeight
        x: 0
        radius: height / 2
        color: "#3c3836"
        border.color: "#fe8019"
        border.width: 2

        RowLayout {
            id: pillContent
            anchors.centerIn: parent
            spacing: 18

            Row {
                id: trayRow
                visible: trayRepeater.count > 0
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
                                    modelData.display(island, mouse.x, mouse.y);
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 1
                height: 20
                color: "#504945"
                visible: trayRepeater.count > 0
            }

            Text {
                id: clockText
                color: "#ebdbb2"
                font.pixelSize: 18
                font.bold: true
                font.family: island.fontFam
            }

            Text {
                color: "#ebdbb2"
                font.pixelSize: 14
                font.family: island.fontFam
                text: {
                    const d = UPower.displayDevice;
                    if (!d || !d.ready)
                        return "…";
                    const charging = d.state === UPowerDeviceState.Charging;
                    return (charging ? " " : "  ") + Math.round(d.percentage * 100) + "%";
                }
            }

            Text {
                color: "#ebdbb2"
                font.pixelSize: 14
                font.family: island.fontFam
                text: {
                    const sink = Pipewire.defaultAudioSink;
                    if (!sink || !sink.audio)
                        return "…";
                    return sink.audio.muted ? "" : "  " + Math.round(sink.audio.volume * 100) + "%";
                }
            }

            Text {
                color: "#ebdbb2"
                font.pixelSize: 14
                font.family: island.fontFam
                text: " " + brightnessState.percent + "%"
            }
        }
    }

    Item {
        id: anim

        state: island.revealed ? "expanded" : "collapsed"
        states: [
            State {
                name: "collapsed"
                PropertyChanges {
                    target: pillContainer
                    y: -island.pillHeight
                }
                PropertyChanges {
                    target: pillContent
                    opacity: 0
                }
            },
            State {
                name: "expanded"
                PropertyChanges {
                    target: pillContainer
                    y: island.topPadding
                }
                PropertyChanges {
                    target: pillContent
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: "collapsed"
                to: "expanded"
                SequentialAnimation {
                    NumberAnimation {
                        target: pillContainer
                        property: "y"
                        duration: 170
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        target: pillContent
                        property: "opacity"
                        duration: 130
                    }
                }
            },
            Transition {
                from: "expanded"
                to: "collapsed"
                SequentialAnimation {
                    NumberAnimation {
                        target: pillContent
                        property: "opacity"
                        duration: 90
                    }
                    NumberAnimation {
                        target: pillContainer
                        property: "y"
                        duration: 170
                        easing.type: Easing.InOutCubic
                    }
                }
            }
        ]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "hh:mm")
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    QtObject {
        id: brightnessState
        property int percent: 0
    }

    Process {
        id: brightnessProc
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(",");
                if (parts.length >= 4)
                    brightnessState.percent = parseInt(parts[3]);
            }
        }
    }

    FileView {
        path: "/sys/class/backlight/" + island.backlightDevice + "/brightness"
        watchChanges: true
        onFileChanged: brightnessProc.running = true
        Component.onCompleted: brightnessProc.running = true
    }
}
