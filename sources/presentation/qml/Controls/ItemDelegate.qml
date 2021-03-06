import QtQuick 2.6
import QtQuick.Templates 2.0 as T
import QtQuick.Layouts 1.3

T.ItemDelegate {
    id: control

    property alias iconSource: content.iconSource

    font.pixelSize: palette.fontPixelSize
    implicitHeight: palette.controlBaseSize

    contentItem: RowLayout {
        ContentItem {
            id: content
            font: control.font
            text: control.text
            textColor: control.highlighted ? palette.selectedTextColor : palette.textColor
            Layout.margins: palette.padding
        }

        Item { Layout.fillWidth: true }
    }

    background: Rectangle {
        implicitHeight: palette.controlBaseSize
        border.color: control.activeFocus ? palette.selectionColor : "transparent"
        color: {
            if (control.down) return palette.highlightColor;
            if (control.highlighted) return palette.selectionColor;
            return palette.sunkenColor;
        }
    }
}
