import QtQuick 2.6
import QtQuick.Templates 2.0 as T
import QtQuick.Layouts 1.3

import "../Shaders" as Shaders

T.CheckBox {
    id: control

    font.pixelSize: palette.fontPixelSize
    height: palette.controlBaseSize
    leftPadding: 0
    spacing: palette.spacing
    implicitWidth: text.length > 0 ? contentItem.implicitWidth + spacing : indicator.implicitWidth
    opacity: enabled ? 1 : 0.33

    indicator: Rectangle {
        implicitWidth: palette.controlBaseSize
        implicitHeight: palette.controlBaseSize
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        color: palette.sunkenColor
        border.color: control.activeFocus ? palette.highlightColor : "transparent"

        ColoredIcon {
            anchors.fill: parent
            anchors.margins: parent.width * 0.1
            source: "qrc:/ui/ok.svg"
            color: control.down ? palette.highlightColor : palette.textColor
            visible: control.checked || control.down
        }

        Shaders.Hatch {
            anchors.fill: parent
            color: palette.sunkenColor
            visible: !control.enabled
        }
    }

    contentItem: Label {
        text: control.text
        font: control.font
        leftPadding: indicator.width + spacing
        verticalAlignment: Text.AlignVCenter
    }
}
