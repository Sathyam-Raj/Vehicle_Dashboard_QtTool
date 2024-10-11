import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls.Material 2.15
import QtQuick.Shapes 1.15
import QtMultimedia 6.7

ApplicationWindow {
    visible: true
    width: 800
    height: 650
    title: "Vehicle Dashboard"

    Material.theme: Material.Dark
    Material.accent: Material.Blue
    Material.primary: "#37474F"
    Material.foreground: "white"

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        RowLayout {
            spacing: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            Button {
                text: "Speedometer"
                onClicked: {
                    dashboardStack.currentIndex = 0;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 0 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
            Button {
                text: "Fuel Gauge"
                onClicked: {
                    dashboardStack.currentIndex = 1;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 1 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
            Button {
                text: "Battery"
                onClicked: {
                    dashboardStack.currentIndex = 2;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 2 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
            Button {
                text: "Map"
                onClicked: {
                    dashboardStack.currentIndex = 3;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 3 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
            Button {
                text: "Rotation"
                onClicked: {
                    dashboardStack.currentIndex = 4;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 4 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
            Button {
                text: "Video"
                onClicked: {
                    dashboardStack.currentIndex = 5;
                }
                background: Rectangle {
                    color: dashboardStack.currentIndex === 5 ? "white" : "green"
                    radius: 20
                }
                Material.foreground: "black"
            }
        }

        StackLayout {
            id: dashboardStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            Pane {
                id: speedometerPane
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 20
                    Label {
                        text: "Speedometer"
                        font.pointSize: 18
                        color: Material.foreground
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 20
                    }

                    Item {
                        width: 350
                        height: 350
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Shape {
                            width: 250
                            height: 250
                            anchors.centerIn: parent

                            ShapePath {
                                strokeColor: "#FF4081"
                                strokeWidth: 20
                                fillColor: "transparent"
                                PathAngleArc {
                                    centerX: 125
                                    centerY: 125
                                    radiusX: 100
                                    radiusY: 100
                                    startAngle: -270
                                    sweepAngle: 240
                                }
                            }
                        }

                        Rectangle {
                            width: 4
                            height: 80
                            color: "red"
                            radius: 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 175
                            rotation: -180 + (speedometerValue / 200) * 240
                            transformOrigin: Item.Bottom
                            id: needle
                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 5
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }

                        Text {
                            text: "0"
                            font.pixelSize: 12
                            anchors.left: parent.left
                            anchors.leftMargin: 175
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 40
                            color: Material.foreground
                        }

                        Text {
                            text: "50"
                            font.pixelSize: 12
                            anchors.left: parent.left
                            anchors.leftMargin: 60
                            anchors.top: parent.top
                            anchors.topMargin: 230
                            color: Material.foreground
                        }

                        Text {
                            text: "100"
                            font.pixelSize: 12
                            anchors.left: parent.left
                            anchors.leftMargin: 60
                            anchors.top: parent.top
                            anchors.topMargin: 100
                            color: Material.foreground
                        }

                        Text {
                            text: "150"
                            font.pixelSize: 12
                            anchors.right: parent.right
                            anchors.rightMargin: 165
                            anchors.top: parent.top
                            anchors.topMargin: 45
                            color: Material.foreground
                        }

                        Text {
                            text: "200"
                            font.pixelSize: 12
                            anchors.right: parent.right
                            anchors.rightMargin: 60
                            anchors.top: parent.top
                            anchors.topMargin: 100
                            color: Material.foreground
                        }
                    }

                    Button {
                        text: "Accelerator"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        onPressed: {
                            speedUpTimer.start();
                            slowDownTimer.stop();
                        }
                        onReleased: {
                            speedUpTimer.stop();
                            slowDownTimer.start();
                        }
                        Material.background: Material.accent
                        Material.foreground: "black"
                    }
                }
            }

            Pane {
                id: fuelPane
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 20
                    Label {
                        text: "Fuel Level"
                        font.pointSize: 18
                        color: Material.foreground
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 20
                    }

                    RowLayout {
                        spacing: 10
                        Label {
                            text: "Fuel Value:"
                            color: Material.foreground
                            font.pointSize: 14
                        }

                        TextField {
                            id: fuelInput
                            width: 100
                            placeholderText: "Enter fuel value"
                            onTextChanged: {
                                var value = parseInt(fuelInput.text);
                                if (!isNaN(value)) {
                                    fuelGauge.height = Math.min(Math.max(value, 0), 100) * 3; // Adjust height (300 max)
                                }
                            }
                        }
                    }

                    Item {
                        width: 50
                        height: 300
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "#EEEEEE" // Background color for the gauge

                            Rectangle {
                                id: fuelGauge
                                width: parent.width
                                height: 0 // Initial fuel level set to 0
                                color: Material.accent
                                anchors.bottom: parent.bottom
                            }
                        }
                    }
                }
            }

            Pane {
                id: batteryPane
                Image {
                    id: backgroundImage
                    source: "qrc:/images/background2.jpg"
                    anchors.fill: parent
                    fillMode: Image.Stretch
                }
                RowLayout {
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    spacing: 50

                    ColumnLayout {
                        spacing: 10
                        Label { text: "Enter value for battery 1:"; color: Material.foreground }
                        TextField {
                            id: batteryInput1
                            placeholderText: "Battery 1"
                            onTextChanged: updateBatteryValues()
                        }

                        Label { text: "Enter value for battery 2:"; color: Material.foreground }
                        TextField {
                            id: batteryInput2
                            placeholderText: "Battery 2"
                            onTextChanged: updateBatteryValues()
                        }

                        Label { text: "Enter value for battery 3:"; color: Material.foreground }
                        TextField {
                            id: batteryInput3
                            placeholderText: "Battery 3"
                            onTextChanged: updateBatteryValues()
                        }

                        Label { text: "Enter value for battery 4:"; color: Material.foreground }
                        TextField {
                            id: batteryInput4
                            placeholderText: "Battery 4"
                            onTextChanged: updateBatteryValues()
                        }

                        Label { text: "Enter value for battery 5:"; color: Material.foreground }
                        TextField {
                            id: batteryInput5
                            placeholderText: "Battery 5"
                            onTextChanged: updateBatteryValues()
                        }

                        Label { text: "Enter value for battery 6:"; color: Material.foreground }
                        TextField {
                            id: batteryInput6
                            placeholderText: "Battery 6"
                            onTextChanged: updateBatteryValues()
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    GridLayout {
                        columns: 3
                        rowSpacing: 30
                        columnSpacing: 30
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 10

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 1"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge1
                                    width: parent.width
                                    height: 0
                                    color: batteryColor1
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput1.text ? batteryInput1.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 2"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge2
                                    width: parent.width
                                    height: 0
                                    color: batteryColor2
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput2.text ? batteryInput2.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 3"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge3
                                    width: parent.width
                                    height: 0
                                    color: batteryColor3
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput3.text ? batteryInput3.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 4"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge4
                                    width: parent.width
                                    height: 0
                                    color: batteryColor4
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput4.text ? batteryInput4.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 5"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge5
                                    width: parent.width
                                    height: 0
                                    color: batteryColor5
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput5.text ? batteryInput5.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 30
                            Label {
                                text: "Battery 6"
                                color: Material.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Rectangle {
                                width: 80
                                height: 130
                                color: "#EEEEEE"

                                Rectangle {
                                    id: batteryGauge6
                                    width: parent.width
                                    height: 0
                                    color: batteryColor6
                                    anchors.bottom: parent.bottom
                                }
                                Item {
                                    width: 190 // Set width
                                    height: 175 // Set height
                                    anchors.centerIn: parent

                                    Image {
                                        source: "qrc:/images/file (1) (1).png"
                                        width: parent.width
                                        height: parent.height
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: batteryInput6.text ? batteryInput6.text + "%" : "0%"
                                    color: "black"
                                }
                            }
                        }
                    }
                }
            }

            Pane {
                id: mapPane
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 20
                    Label {
                        text: "Map"
                        font.pointSize: 18
                        color: Material.foreground
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 20
                    }

                    Map {
                        id: vehicleMap
                        plugin: Plugin {
                            name: "osm" // OpenStreetMap plugin
                        }
                        center: QtPositioning.coordinate(20.5937, 78.9629)
                        zoomLevel: 5 // Initial zoom level
                        anchors.fill: parent

                        MouseArea {
                            id: mapDragArea
                            anchors.fill: parent

                            property var lastMousePosition
                            property real lastLatitude
                            property real lastLongitude

                            // Store the initial position when the mouse is pressed
                            onPressed: {
                                lastMousePosition = Qt.point(mouse.x, mouse.y);
                                lastLatitude = vehicleMap.center.latitude;
                                lastLongitude = vehicleMap.center.longitude;
                            }

                            // Track the movement and update the map's center as you drag
                            onPositionChanged: {
                                var deltaX = mouse.x - lastMousePosition.x;
                                var deltaY = mouse.y - lastMousePosition.y;

                                // Factor the dragging speed based on the zoom level
                                var dragSensitivity = 1 / Math.pow(2, vehicleMap.zoomLevel - 1); // Adjust sensitivity based on zoom level

                                // Reverse deltaY for correct vertical dragging (latitude)
                                var newLatitude = lastLatitude + deltaY * 0.6 * dragSensitivity;
                                var newLongitude = lastLongitude - deltaX * 0.6 * dragSensitivity;

                                vehicleMap.center.latitude = newLatitude;
                                vehicleMap.center.longitude = newLongitude;
                            }

                            // Mouse released event ensures the map stays where it's dragged to
                            onReleased: {
                                lastMousePosition = null;
                            }
                        }
                    }



                    // Zoom controls
                    RowLayout {
                        spacing: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        Button {
                            text: "Zoom In"
                            onClicked: {
                                vehicleMap.zoomLevel += 1;
                            }
                            background: Rectangle {
                                            color: "black" // Black background
                                            radius: 20
                                        }
                                        contentItem: Text {
                                            text: "Zoom In"
                                            color: "white" // White font color
                                            anchors.centerIn: parent
                                        }
                        }
                        Button {
                            text: "Zoom Out"
                            onClicked: {
                                vehicleMap.zoomLevel -= 1;
                            }
                            background: Rectangle {
                                            color: "black" // Black background
                                            radius: 20
                                        }
                                        contentItem: Text {
                                            text: "Zoom Out"
                                            color: "white" // White font color
                                            anchors.centerIn: parent
                                        }
                        }
                    }
                }
            }
            Pane {
                id: rotationPane
                Image {
                    id: backgroundImage1
                    source: "qrc:/images/file (4).png"
                    width: 275 // Set the desired width
                    height: 275 // Set the desired height
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }

                TextField {
                            id: rotationInput
                            placeholderText: "Enter rotation value"
                            onTextChanged: updateRotation()
                            width: 200
                }
                Text {
                    id: degreeDisplay
                    text: rotationInput.text ? rotationInput.text + "°" : "0°"
                    font.bold: true
                    font.pixelSize: 20
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
               }

                ColumnLayout {
                    spacing: 20
                    anchors.centerIn: parent

                    Item {
                        width: 200
                        height: 200
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: rotatingImage
                            source: "qrc:/images/Remove background project.png"
                            width: 500
                            height: 500
                            fillMode: Image.PreserveAspectFit
                            rotation: rotationInput.text ? parseFloat(rotationInput.text) : 0
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Pane {
                id: videopane

                Camera {
                    id: camera
                    // Optional: Set camera settings (like resolution) here if needed
                }

                CaptureSession {
                    id: captureSession
                    camera: camera // Connect the camera to the capture session
                    videoOutput: videoOutput // Connect the video output to display the feed
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent // Fill the entire pane with video output
                    transform: Scale {
                        id: videoScale
                        origin.x: videoOutput.width / 2
                        origin.y: videoOutput.height / 2
                        xScale: 1.0 // Default scale (no zoom)
                        yScale: 1.0
                    }
                }

                Row {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20

                    Button {
                        text: "+"
                        onClicked: {
                            videoScale.xScale += 0.1 // Zoom in by increasing the scale
                            videoScale.yScale += 0.1
                        }
                    }

                    Button {
                        text: "-"
                        onClicked: {
                            if (videoScale.xScale > 1.0 && videoScale.yScale > 1.0) { // Limit zoom out to the original size
                                videoScale.xScale -= 0.1 // Zoom out by decreasing the scale
                                videoScale.yScale -= 0.1
                            }
                        }
                    }
                }

                Button {
                    text: camera.active ? "Stop Camera" : "Start Camera"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 50
                    onClicked: {
                        if (camera.active) {
                            camera.stop(); // Stop the camera when active
                            videoOutput.visible = false; // Optionally hide the video output when stopped
                        } else {
                            camera.start(); // Start the camera when not active
                            videoOutput.visible = true; // Show video output when the camera starts
                        }
                    }
                }
            }


        }
    }

    property color batteryColor1: "green"
    property color batteryColor2: "green"
    property color batteryColor3: "green"
    property color batteryColor4: "green"
    property color batteryColor5: "green"
    property color batteryColor6: "green"

    function getBatteryColor(value) {
        if (value >= 75) return "green";
        if (value >= 50) return "yellow";
        if (value >= 25) return "orange";
        return "red";
    }

    function updateBatteryGauge(value, gauge, colorProperty) {
        var num = parseInt(value);
        if (!isNaN(num)) {
            gauge.height = Math.min(Math.max(num, 0), 100) * 1.3; // Adjust height (150 max)
            colorProperty = getBatteryColor(num); // Update color property
        } else {
            gauge.height = 0;
            colorProperty = "green"; // Default color
        }
    }

    function updateBatteryValues() {
        batteryColor1 = getBatteryColor(parseInt(batteryInput1.text));
        batteryColor2 = getBatteryColor(parseInt(batteryInput2.text));
        batteryColor3 = getBatteryColor(parseInt(batteryInput3.text));
        batteryColor4 = getBatteryColor(parseInt(batteryInput4.text));
        batteryColor5 = getBatteryColor(parseInt(batteryInput5.text));
        batteryColor6 = getBatteryColor(parseInt(batteryInput6.text));

        updateBatteryGauge(batteryInput1.text, batteryGauge1, batteryColor1);
        updateBatteryGauge(batteryInput2.text, batteryGauge2, batteryColor2);
        updateBatteryGauge(batteryInput3.text, batteryGauge3, batteryColor3);
        updateBatteryGauge(batteryInput4.text, batteryGauge4, batteryColor4);
        updateBatteryGauge(batteryInput5.text, batteryGauge5, batteryColor5);
        updateBatteryGauge(batteryInput6.text, batteryGauge6, batteryColor6);
    }

property real speedometerValue: 0
Timer {
        id: speedUpTimer
        interval: 50
        repeat: true
        onTriggered: {
            if (speedometerValue < 200) {
                speedometerValue += 2;
            }
        }
    }

Timer {
        id: slowDownTimer
        interval: 50
        repeat: true
        onTriggered: {
            if (speedometerValue > 0) {
                speedometerValue -= 2;
            }
        }
    }
function updateRotation() {
        if (rotationInput.text) {
            let value = parseFloat(rotationInput.text);
            if (!isNaN(value)) {
                rotatingImage.rotation = value;
            }
        }
    }
}
