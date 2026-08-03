pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property string device: ""
    property int percent: 0

    property Process detectProc: Process {
        command: ["sh", "-c", "ls /sys/class/backlight 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: {
                const found = text.trim().split("\n").filter(l => l.length > 0);
                if (found.length > 0) {
                    root.device = found[0];
                    watcher.path = "/sys/class/backlight/" + root.device + "/brightness";
                    watcher.reload();
                    queryProc.running = true;
                } else {
                    console.warn("No backlight device found in /sys/class/backlight");
                }
            }
        }
    }

    property Process queryProc: Process {
        command: root.device ? ["brightnessctl", "-d", root.device, "-m"] : []
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(",");
                if (parts.length >= 4)
                    root.percent = parseInt(parts[3]);
            }
        }
    }

    property FileView watcher: FileView {
        watchChanges: true
        onFileChanged: queryProc.running = true
    }

    function setPercent(p) {
        if (root.device)
            Quickshell.execDetached(["brightnessctl", "-d", root.device, "set", p + "%"]);
    }

    Component.onCompleted: detectProc.running = true
}
