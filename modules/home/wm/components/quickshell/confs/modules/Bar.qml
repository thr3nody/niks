import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import "../services"

PanelWindow {
    id: island

    property int revealTriggerWidth: 220
    property int revealTriggerHeight: 6

    property int pillWidth: 360
    property int pillHeight: 45
    property int topPadding: 10
    property int hideDelayMs: 500
    property string fontFam: "JetBrainsMono Nerd Font"

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
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        width: island.revealed ? island.pillWidth : island.revealTriggerWidth
        height: island.revealed ? (island.topPadding + island.pillHeight) : island.revealTriggerHeight
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
        border {
            color: "#fe8019"
            width: 2
        }

        RowLayout {
            id: pillContent
            anchors.centerIn: pillContainer
            spacing: 18

            TrayRow {
                id: trayRow
                targetWindow: island
            }

            Rectangle {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 1
                height: 20
                color: "#504945"
                visible: trayRow.count > 0
            }

            Text {
                id: clockText
                color: "#ebdbb2"
                font {
                    pixelSize: 18
                    bold: true
                    family: island.fontFam
                }
            }

            Text {
                color: "#ebdbb2"
                font {
                    pixelSize: 14
                    family: island.fontFam
                }
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
                font {
                    pixelSize: 14
                    family: island.fontFam
                }
                text: {
                    const sink = Pipewire.defaultAudioSink;
                    if (!sink || !sink.audio)
                        return "…";
                    return sink.audio.muted ? "" : "  " + Math.round(sink.audio.volume * 100) + "%";
                }
            }

            Text {
                color: "#ebdbb2"
                font {
                    pixelSize: 14
                    family: island.fontFam
                }
                text: " " + Brightness.percent + "%"
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
}
