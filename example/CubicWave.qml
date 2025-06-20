import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: layout
    anchors.fill: parent
    spacing: 6
    Rectangle {
        color: 'teal'
        Layout.fillWidth: true
        Layout.minimumWidth: 50
        Layout.preferredWidth: 100
        Layout.maximumWidth: 300
        Layout.minimumHeight: 150
        Text {
            anchors.centerIn: parent
            text: parent.width + 'x' + parent.height
        }
    }
    Rectangle {
        Control {
            anchors.fill: parent

            Item {
                anchors.centerIn: parent
                transform: Translate {
                    x: -320
                    y: -60
                }

                Repeater {
                    model: 20
                    delegate: Rectangle {
                        width: 120
                        height: 25
                        // anchors.centerIn: parent
                        x: 10 + index * 30
                        y: 40
                        // calm svg colors
                        readonly property var colors: ["coral", "darkblue", "deepskyblue", "forestgreen", "mediumvioletred", "steelblue"]
                        color: colors[index % colors.length]
                        border.color: "#222"
                        border.width: 11
                        radius: 10

                        NumberAnimation on rotation {
                            from: 0 + index * 10
                            to: 360 + index * 10
                            duration: 15000
                            loops: Animation.Infinite
                        }
                    }
                }
            }
        }
    }
}
