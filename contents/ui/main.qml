import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    
    Layout.minimumWidth: 60
    Layout.preferredWidth: 60
    Layout.fillWidth: false
    
    height: Kirigami.Units.gridUnit * 2
    
    Timer {
        interval: 1000
        running: Plasmoid.active
        repeat: true
        onTriggered: {
            timeLabel.text = getInternetTime()
        }
    }
    
    function getInternetTime() {
        const now = new Date()
        const utc = now.getTime() + (now.getTimezoneOffset() * 60000)
        const bmt = new Date(utc + (3600000))
        
        const seconds = (bmt.getHours() * 3600) + 
                       (bmt.getMinutes() * 60) + 
                       bmt.getSeconds() +
                       (bmt.getMilliseconds() / 1000)
                     
        const beats = seconds / 86.4
        
        return '@' + Math.floor(beats).toString().padStart(3, '0')
    }
    
    PlasmaComponents.Label {
        id: timeLabel
        anchors.centerIn: parent
        font.pointSize: 12
        text: getInternetTime()
    }
}
