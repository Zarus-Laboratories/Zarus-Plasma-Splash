import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: root
    color: "BLACK"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 10

            anchors.centerIn: parent

            source: "images/Zarus_logo.svg"

            sourceSize.width: size
            sourceSize.height: size
        }

        Image {
            id: busyIndicator
            //in the middle of the remaining space
            y: (parent.height - (parent.height - logo.y)) - (units.gridUnit * 3.5)
            x: (parent.width - (parent.width - logo.x)) - (units.gridUnit * 1.5)
            //anchors.horizontalCenter: parent.horizontalCente
            source: "images/simbolo.svg"
            sourceSize.height: units.gridUnit * 16
            sourceSize.width: units.gridUnit * 16
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2500
                loops: Animation.Infinite
            }
        }
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: units.gridUnit
            }
            Text {
                color: "#eff0f1"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Research and Development")
            }
            Image {
                source: "images/zarus.svgz"
                sourceSize.height: units.gridUnit
                sourceSize.width: units.gridUnit
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
    }
}
