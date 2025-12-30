import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true

    SplitView {
        anchors.fill: parent

        ColumnLayout {
            SplitView.preferredWidth: 60

            spacing: 5
            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: header_row.height
            }

            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: content_row.height

                Text {
                    text: content_row.height
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: footer_row.height
            }
        }

        SplitView {
            orientation: Qt.Vertical
            SplitView.fillWidth: true

            Rectangle {
                id: header_row
                SplitView.preferredHeight: 60

                Text {
                    text: parent.width
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: content_row
                SplitView.fillHeight: true
                Graphic {
                    width: parent.width
                    height:parent.height
                }
            }

            Rectangle {
                id: footer_row
                SplitView.preferredHeight: 60

                Text {
                    text: parent.width
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        ColumnLayout {
            SplitView.preferredWidth: 60

            spacing: 5
            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: header_row.height
            }

            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: content_row.height

                Text {
                    text: content_row.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: footer_row.height
            }
        }
    }
}
