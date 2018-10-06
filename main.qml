import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Timeline
    {
        width: parent.width - 30
        height: 80
        anchors.margins: 15
        anchors.top: parent.top
        anchors.left: parent.left
    }
}
