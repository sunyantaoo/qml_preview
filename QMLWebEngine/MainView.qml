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
