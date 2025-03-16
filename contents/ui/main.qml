import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    implicitWidth: 120
    implicitHeight: 70
    
    // Timer to update the time display
    Timer {
        interval: 1000 // Update every second
        running: true
        repeat: true
        onTriggered: timeLabel.text = getInternetTime()
    }
    
    // Function to calculate Swatch Internet Time
    function getInternetTime() {
        let now = new Date()
        let utc = now.getTime() + (now.getTimezoneOffset() * 60000)
        let bmt = new Date(utc + (3600000 * 1)) // BMT is UTC+1
        
        let seconds = (bmt.getHours() * 3600) + 
                     (bmt.getMinutes() * 60) + 
                     bmt.getSeconds() +
                     (bmt.getMilliseconds() / 1000)
                     
        let beats = (seconds / 86.4) // 86.4 seconds = 1 beat
        
        return '@' + Math.floor(beats).toString().padStart(3, '0')
    }
    
    // The widget layout
    ColumnLayout {
        anchors.fill: parent
//	Layout.preferredWidth: 400
	Layout.minimumWidth: 120
        
	PlasmaComponents.Label {
            id: timeLabel
            Layout.alignment: Qt.AlignLeft
	    Layout.preferredWidth: 120
            font.pointSize: 14
            text: getInternetTime()
        }
        
        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignCenter
            text: "Swatch Internet Time"
            font.pointSize: 10
            opacity: 0.7
        }
    }
}
