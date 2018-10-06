import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: root

    property int  duration: 5000 // in ms
    property int  fromMs:  0
    property int  toMs: 5000




    Rectangle{
        id: sliderBackground
        width: root.width
        height: root.height
        color: "orange"



        Rectangle{
            id: theSlider

            property bool  movable: false
            color: "grey"
            height: root.height - 5
            anchors.top: parent.top

            width: root.width/duration * Math.abs(root.toMs - root.fromMs)

            radius: 3
            x: root.fromMs * root.width/root.duration

            Connections{
                target: root
                onToMsChanged:  {
                    theSlider.width = root.width/duration * Math.abs(root.toMs - root.fromMs)
                    theSlider.x = root.fromMs * root.width/root.duration
                }


            }

            MouseArea{

                id: sliderMouseArea
                anchors.fill: parent
                property int  initialX: 0
                property int  currentDuration : 0
                onPressed: {
                    theSlider.movable = true
                    sliderMouseArea.initialX = mouseX
                    sliderMouseArea.currentDuration = Math.abs(root.toMs - root.fromMs)
                }
                onClicked:
                {
                    theSlider.movable = false
                }
                onMouseXChanged: {
                    if(theSlider.movable )
                    {
                        if(mouseX > sliderMouseArea.initialX)
                        {

                            theSlider.x = theSlider.x + Math.abs(mouseX - sliderMouseArea.initialX)

                        }
                        else
                        {
                            theSlider.x = theSlider.x - Math.abs(mouseX - sliderMouseArea.initialX)
                        }

                        if(theSlider.x < 0)
                        {
                            theSlider.x = 0
                        }
                        if((theSlider.x + theSlider.width) > root.width)
                        {
                            theSlider.x = root.width - theSlider.width
                        }


                        root.fromMs = theSlider.x * duration/root.width
                        root.toMs = root.fromMs + sliderMouseArea.currentDuration

                        if(root.toMs > root.duration)
                        {
                            root.toMs = root.duration
                        }
                        if(root.fromMs < 0)
                        {
                            root.fromMs = 0
                        }

                    }
                    else
                    {
                        //                        if(mouseX < sliderMouseArea.initialX)
                        //                        {
                        //                            theSlider.x = theSlider.x - Math.abs(mouseX - sliderMouseArea.initialX)
                        //                        }
                        //                        else
                        //                        {
                        //                             theSlider.x = theSlider.x + Math.abs(mouseX - sliderMouseArea.initialX)
                        //                        }

                    }

                }
            }
        }
    }
}
