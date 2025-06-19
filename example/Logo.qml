import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Shapes

Rectangle {
    id: root
    width: 200
    height: 140
    color: "#41cd52"

    Text {
        id: text
        anchors.centerIn: parent
        font.pixelSize: 64
        font.weight: Font.ExtraBold
        color: "#fff"
        text: "QML"
        transform: Translate {
            y: -20
        }
    }

    Rectangle {
        color: "#35322f"
        width: parent.width
        height: 42
        anchors.bottom: parent.bottom

        Text {
            anchors.centerIn: parent
            font.pixelSize: 28
            font.weight: Font.ExtraBold
            color: "#d7d6d5"
            text: "Sandbox"
            transform: Translate {
                x: -8
            }
        }
    }

    Rectangle {
        color: "white"
        width: 100
        height: 200
        rotation: 45
        x: -115
        y: -65
    }

    Rectangle {
        color: "white"
        width: 100
        height: 200
        rotation: 45
        x: 115
        y: 105
    }

    Button {
        width: 360
        height: 120
        background: Rectangle {
            id: id_bkg
            color: "#de6c01"
        }
        text: qsTr("select backgroup color")
        onClicked: colorDialog.open()
    }

    ColorDialog {
        id: colorDialog
        selectedColor: id_bkg.color
        onAccepted: id_bkg.color = selectedColor
    }

     Shape {
     width: 200
     height: 150
     anchors.centerIn: parent
     ShapePath {
         strokeWidth: 4
         strokeColor: "red"
         fillGradient: LinearGradient {
             x1: 20; y1: 20
             x2: 180; y2: 130
             GradientStop { position: 0; color: "blue" }
             GradientStop { position: 0.2; color: "green" }
             GradientStop { position: 0.4; color: "red" }
             GradientStop { position: 0.6; color: "yellow" }
             GradientStop { position: 1; color: "cyan" }
         }
         strokeStyle: ShapePath.DashLine
         dashPattern: [ 1, 4 ]
         startX: 20; startY: 20
         PathLine { x: 180; y: 130 }
         PathLine { x: 20; y: 130 }
         PathLine { x: 20; y: 20 }
     }
 }

}
