import QtQuick
import QtGraphs

GraphsView {
    anchors.fill: parent
    anchors.margins: 16
    theme: GraphsTheme {
        readonly property color c1: "#DBEB00"
        readonly property color c2: "#373F26"
        readonly property color c3: Qt.lighter(c2, 1.5)
        colorScheme: GraphsTheme.ColorScheme.Dark
        seriesColors: ["#2CDE85", "#DBEB00"]
        grid.mainColor: c3
        grid.subColor: c2
        axisX.mainColor: c3
        axisY.mainColor: c3
        axisX.subColor: c2
        axisY.subColor: c2
        axisX.labelTextColor: c1
        axisY.labelTextColor: c1
    }
    axisX: ValueAxis {
        max: 5
        tickInterval: 1
        subTickCount: 9
        labelDecimals: 1
    }
    axisY: ValueAxis {
        max: 10
        tickInterval: 1
        subTickCount: 4
        labelDecimals: 1
    }
}
