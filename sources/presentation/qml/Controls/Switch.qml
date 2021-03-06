import QtQuick 2.6
import QtQuick.Templates 2.0 as T

import "../Shaders" as Shaders

T.Switch {
    id: control

    property bool inputChecked: checked
    property alias textColor: text.color
    property alias backgroundColor: backgroundItem.color

    spacing: palette.spacing
    font.pixelSize: palette.fontPixelSize
    implicitWidth: contentItem.implicitWidth
    implicitHeight: palette.controlBaseSize

    onInputCheckedChanged: if (checked != inputChecked) checked = inputChecked

    indicator: Rectangle {
        id: backgroundItem
        implicitWidth: palette.controlBaseSize
        implicitHeight: palette.controlBaseSize / 4
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: height / 2
        border.color: control.activeFocus ? palette.highlightColor : "transparent"
        color: control.inputChecked ? palette.selectionColor : palette.sunkenColor;

        Rectangle {
            x: control.checked ? parent.width - width : 0
            anchors.verticalCenter: parent.verticalCenter
            width: palette.controlBaseSize / 1.5
            height: palette.controlBaseSize / 1.5
            radius: height / 2
            color: control.pressed ? palette.highlightColor : palette.buttonColor;

            Shaders.Hatch {
                anchors.fill: parent
                color: palette.sunkenColor
                visible: !control.enabled
            }
        }
    }

    contentItem: Text {
        id: text
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: palette.textColor
        leftPadding: indicator.width + control.spacing
    }
}
