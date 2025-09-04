import QtQuick
import QtQuick.Window

Item {
    id: root
    // You must point this at the content you want to invert against.
    // Ideally a sibling "content" item, not an ancestor that contains this item.
    required property Item sourceItem

    // capture exactly our on-screen rectangle from sourceItem
    property rect srcRect: Qt.rect(x, y, root.width, root.height)

    ShaderEffectSource {
        id: src
        visible: false
        live: true
        sourceItem: root.sourceItem
        sourceRect: root.srcRect
        hideSource: false
    }

    ShaderEffect {
        anchors.fill: parent
        property var source: src

        fragmentShader: "qrc:/shaders/invert.frag.qsb"
        vertexShader:   "qrc:/shaders/passthrough.vert.qsb"
    }
}
