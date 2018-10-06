import QtQuick 2.9
import QtQuick.Controls 2.2
Item {

    id: root
    property int  timeLineWidth: 640
    property int  timelineHeight: 80
    property int  fromMs: 0
    property int toMs: 60000
    property int  duration: 240000

    Rectangle
    {
        id: timelineBG
        width: root.width
        height: root.height
        color: "grey"
        TimeLegend{
            width: root.width
            height: root.height/3
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            miniTick: 2
            tick: 8
            fromMs: root.fromMs
            toMs: root.toMs

            onToMsChanged: {

                testTimeLineScrol.toMs = toMs
                testTimeLineScrol.fromMs = fromMs
            }
        }

        TimeLineScroll{
            id: testTimeLineScrol
            width: root.width
            height: root.height/3
            y: root.height + 20
            anchors.left: parent.left
            fromMs: root.fromMs
            toMs: root.toMs
            duration: root.duration


            onFromMsChanged: {
                root.fromMs = fromMs
            }
            onToMsChanged: {
                root.toMs = toMs
            }
        }

        MouseArea
        {
            id: timeLineMainMouseArea
            anchors.fill: parent
            property int  initialX: 0

            function zoomTimeLine(angleDelta)
            {
                var theMsZoomStep = 0
                var theCurrentDuration = Math.abs(root.toMs - root.fromMs)
                if( theCurrentDuration<= 1000)
                {
                    theMsZoomStep = 50
                }
                else if(theCurrentDuration <= 60000)
                {
                    theMsZoomStep = 1000
                }
                else
                {
                    theMsZoomStep = 5000
                }

                if(angleDelta > 0)
                {


                    if(root.toMs >= root.duration)
                    {
                        root.fromMs = 0
                        root.toMs = root.duration
                    }

                    else if(root.toMs < root.duration)
                    {
                        root.toMs = root.toMs + theMsZoomStep

                    }
                    else
                    {
                        root.toMs = root.duration

                    }

                }
                else
                {

                    if(Math.abs(root.toMs - root.fromMs) > 500)
                    {
                        root.toMs = root.toMs - theMsZoomStep
                    }
                }

            }

            onPressed: {
                selectRec.width = 1
                selectRec.height = root.height
                selectRec.visible = true
                selectRec.x = timeLineMainMouseArea.mouseX
                selectRec.y = timeLineMainMouseArea.mouseY

                timeLineMainMouseArea.initialX = mouseX

            }

            onMouseXChanged: {
                if(mouseX > selectRec.x) // ben phai
                {
                    selectRec.width = mouseX - selectRec.x
                }
                else
                {
                    selectRec.x = mouseX
                    selectRec.width = Math.abs(mouseX - timeLineMainMouseArea.initialX)
                }

            }

            onClicked: {

            }

            onWheel: {
                console.log("Wheel X: " + wheel.angleDelta.x + " - Wheel Y: " + wheel.angleDelta.y)
                timeLineMainMouseArea.zoomTimeLine(wheel.angleDelta.y)

            }

        }

        Rectangle{
            id: selectRec
            width: 0
            height: 0
            anchors.top: parent.top
            visible: false
            color: "black"
            opacity: 0.5
            border.color: "black"
            border.width: 1
        }
    }










}
