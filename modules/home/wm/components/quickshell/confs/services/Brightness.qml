pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    // `ls /sys/class/backlight/`
    property string device: "amdgpu_bl1"
    property int percent: 0

    property Process proc: Process {
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(",");
                if (parts.length >= 4)
                    root.percent = parseInt(parts[3]);
            }
        }
    }

    property FileView watcher: FileView {
        path: "/sys/class/backlight/" + root.device + "/brightness"
        watchChanges: true
        onFileChanged: root.proc.running = true
        Component.onCompleted: root.proc.running = true
    }
}
