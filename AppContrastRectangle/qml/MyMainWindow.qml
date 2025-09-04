import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Window {
    width: 800
    height: 600
    visible: true
    color: "whitesmoke"

    Text {
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        // Using CommonUtils.js
        text: "Demo app contrast rectangle\nHover cursor over colored rectangles"
    }

    Item {
        id: rectaglesItem
        anchors.fill: parent
        anchors.margins: 60

        GridLayout {
            anchors.fill: parent
            readonly property var colors: [
                "red", "lime", "blue",
                 Qt.darker("red", 2), Qt.darker("lime"), Qt.darker("blue"),
                "yellow", "cyan", "magenta",
                 Qt.darker("yellow", 2), Qt.darker("cyan"), Qt.darker("magenta"),
                "black", "white", "gray",
                "olivedrab", "orange", "paleturquoise" ]

            columns: 3
            rows: 6
            columnSpacing: 4
            rowSpacing: 4

            Repeater {
                model: parent.colors
                delegate: Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: modelData
                }
            }
        }
    }
}
