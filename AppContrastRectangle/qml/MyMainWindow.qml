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

        text: "Demo app contrast rectangle\nHover cursor over colored rectangles"
    }

    Item {
        id: rectaglesItem
        anchors.fill: parent
        anchors.margins: 60

        GridLayout {
            id: colorsGrid
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
                model: colorsGrid.colors
                delegate: Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: modelData

                    Text {
                        anchors.centerIn: parent
                        text: index
                        font.bold: true
                        font.pixelSize: 20
                        color: colorsGrid.colors[ index < colorsGrid.colors.length - 5 ? index + 5 : index + 5 - colorsGrid.colors.length ]
                    }
                }
            }
        }
        MouseArea {
            id: mouseTracker
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
        }
    }

    // A parent item for ContrastRectangle
    // that must be located at the same position as
    // an item to inverse colors.
    // Otherwise you would have to deal with ContrastRectangle.srcRect property
    // to set the rectangle for uncerlying pixels.
    Item {
        anchors.fill: rectaglesItem

        ContrastRectangle {
            sourceItem: rectaglesItem
            visible: mouseTracker.containsMouse

            readonly property int idealWidth: 100
            readonly property int idealHeight: 100

            readonly property int idealTopLeftX: mouseTracker.mouseX - idealWidth / 2
            readonly property int idealTopLeftY: mouseTracker.mouseY - idealHeight / 2
            readonly property int idealBottomRightX: mouseTracker.mouseX + idealWidth / 2
            readonly property int idealBottomRightY: mouseTracker.mouseY + idealHeight / 2

            x: Math.max( idealTopLeftX, 0);
            y: Math.max( idealTopLeftY, 0);

            function visibleLength(x0, xMax, idealLen) {
                if (x0 >= 0) {
                    return Math.min(idealLen, xMax - x0 );
                }

                return Math.min(idealLen +x0, xMax );
            }

            width:  visibleLength(idealTopLeftX, rectaglesItem.width, idealHeight )
            height: visibleLength(idealTopLeftY, rectaglesItem.height, idealWidth )

            Rectangle {
                anchors.fill: parent
                color: "transparent"              // center is visually transparent
                border.color: "black"
                border.width: 2
            }
        }
    }

}
