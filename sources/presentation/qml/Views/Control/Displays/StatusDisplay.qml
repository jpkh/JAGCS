import QtQuick 2.6
import QtQuick.Layouts 1.3
import JAGCS 1.0

import "qrc:/Controls" as Controls
import "qrc:/Indicators" as Indicators
import "../Command"

BaseDisplay {
    id: root

    property int mode: Domain.None
    property var availableModes: []
    property bool armed: false
    property real batteryVoltage: 0
    property real batteryCurrent: 0
    property int batteryPercentage: 0

    implicitHeight: row.height

    RowLayout {
        id: row
        anchors.centerIn: parent
        width: parent.width

        Indicators.BatteryIndicator {
            id: battery
            percentage: batteryPercentage
            Layout.alignment: Qt.AlignLeft
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignLeft

            Controls.Label {
                font.pixelSize: palette.fontPixelSize * 0.6
                font.bold: true
                color: batteryVoltage > 0.01 ? palette.textColor : palette.sunkenColor
                text: batteryVoltage.toFixed(2) + qsTr(" V")
            }

            Controls.Label {
                font.pixelSize: palette.fontPixelSize * 0.6
                font.bold: true
                color: {
                    if (batteryCurrent < -0.01)
                        return palette.positiveColor;
                    if (batteryCurrent > 0.0)
                        return palette.textColor;
                    if (batteryCurrent > 5.0)
                        return palette.cautionColor;
                    if (batteryCurrent > 10.0)
                        return palette.dangerColor;

                    return palette.sunkenColor;
                }
                text: batteryCurrent.toFixed(2) + qsTr(" A")
            }
        }

        CommandModeBox {
            mode: root.mode
            model: availableModes
            enabled: online
            font.pixelSize: palette.fontPixelSize * 0.75
            font.bold: true
            Layout.fillWidth: true
        }

        CommandSwitch {
            text: armed ? qsTr("DISARM") : qsTr("ARM")
            enabled: online
            font.pixelSize: palette.fontPixelSize * 0.75
            font.bold: true
            command: Command.ArmDisarm
            inputChecked: armed
        }
    }
}
