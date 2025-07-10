import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true

    header: ColumnLayout {
        spacing: 0
        height: 150
        TabBar {
            id: bar
            TabButton {
                text: "Home"
                width: implicitWidth
            }
            TabButton {
                text: "Second"
                width: implicitWidth
            }
            TabButton {
                text: "Third"
                width: implicitWidth
            }
        }
        StackLayout {
            currentIndex: bar.currentIndex
            Rectangle {
                id: homeTab
                color: "#ad3e4a"

                Row {}
            }
            Rectangle {
                id: discoverTab
                color: "#39d379"
            }
            Rectangle {
                id: activityTab
                color: "#1248ac"
            }
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        Rectangle {
            implicitWidth: 200
            SplitView.minimumWidth: 100
            SplitView.maximumWidth: 300
            color: "#2d5Fcc"
        }
        Rectangle {
            SplitView.fillWidth: true
            color: "#8dd31e"
        }
        Rectangle {
            implicitWidth: 200
            SplitView.minimumWidth: 100
            SplitView.maximumWidth: 300
            color: "#3d0219"
        }
    }
}
