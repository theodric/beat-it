import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

ColumnLayout {
    id: configItem
    
    property alias cfg_fontSize: fontSizeSpinBox.value
    property alias cfg_verticalOffset: verticalOffsetSpinBox.value
    property alias cfg_widgetWidth: widthSpinBox.value

    Kirigami.FormLayout {
        Layout.fillWidth: true

        QQC2.SpinBox {
            id: fontSizeSpinBox
            Kirigami.FormData.label: "Font size:"
            from: 8
            to: 24
        }

        QQC2.SpinBox {
            id: verticalOffsetSpinBox
            Kirigami.FormData.label: "Vertical offset:"
            from: -10
            to: 10
        }

        QQC2.SpinBox {
            id: widthSpinBox
            Kirigami.FormData.label: "Widget width:"
            from: 40
            to: 120
            stepSize: 5
        }
    }
}
