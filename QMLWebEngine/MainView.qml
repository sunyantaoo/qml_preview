import QtQml
import QtCore

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Timeline

import QtQuick3D
import QtQuick3D.AssetUtils
import QtQuick3D.Helpers
import QtQuick3D.Particles3D

import QtGraphs
import QtTest
import QtWebSockets

Window {
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
                Loader {
                    id: mLoader
                    anchors.fill: parent
                    source: d_url
                    onStatusChanged: {
                        if (mLoader.status == Loader.Error) {
                            let errorInfo = sourceComponent.errorString();
                            mText.text = errorInfo.replace(d_url, "");
                            mDialog.open();
                        }
                    }
                }

                Popup {
                    id: mDialog
                    width: parent.width * 0.5
                    anchors.centerIn: parent
                    visible: false

                    Text {
                        id: mText
                        width: parent.width
                        anchors.centerIn: parent
                        wrapMode: Text.Wrap
                        font.pixelSize: 30
                        color: "#b42323"
                    }
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
