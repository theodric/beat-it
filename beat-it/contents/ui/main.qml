import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    
    Layout.minimumWidth: Plasmoid.configuration.widgetWidth
    Layout.preferredWidth: Plasmoid.configuration.widgetWidth
    Layout.fillWidth: false
    
    height: Kirigami.Units.gridUnit * 2
    
    Timer {
        id: updateTimer
        interval: 100
        running: true  // Changed to always run
        repeat: true
        onTriggered: {
            timeLabel.text = getInternetTime()
        }
    }
    
    function getInternetTime() {
        const now = new Date()
        // Get UTC time and add 1 hour (3600000 ms) to get UTC+1
        const utcPlusOne = new Date(now.getTime() + 3600000)
        
        const seconds = (utcPlusOne.getUTCHours() * 3600) + 
                       (utcPlusOne.getUTCMinutes() * 60) + 
                       utcPlusOne.getUTCSeconds() +
                       (utcPlusOne.getUTCMilliseconds() / 1000)
                     
        const beats = seconds / 86.4
        
        return '@' + Math.floor(beats).toString().padStart(3, '0')
    }
    
    PlasmaComponents.Label {
        id: timeLabel
        anchors.centerIn: parent
        anchors.verticalCenterOffset: Plasmoid.configuration.verticalOffset
        font.pointSize: Plasmoid.configuration.fontSize
        text: getInternetTime()
        
        Component.onCompleted: {
            console.log("Label completed")  // Debug log
            timeLabel.text = getInternetTime()
        }
    }
    
    Component.onCompleted: {
        console.log("Root completed")  // Debug log
        updateTimer.start()  // Explicitly start the timer
    }
    
    Connections {
        target: Plasmoid
        function onActiveChanged() {
            console.log("Active changed:", Plasmoid.active)  // Debug log
            if (Plasmoid.active) {
                timeLabel.text = getInternetTime()
                updateTimer.restart()
            }
        }
    }
}
