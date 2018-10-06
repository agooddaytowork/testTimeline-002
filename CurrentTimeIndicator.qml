import QtQuick 2.0

Item {
    id: root
    property bool  movable: false
    property int  initialX: 0

    Rectangle{

        id: indicator
        width: 2
        color: "red"
        height: root.height

        MouseArea{
            anchors.fill: parent

            hoverEnabled: true

            onEntered: {
                cursorShape = Qt.IBeamCursor
            }

            onExited: {
                cursorShape = Qt.ArrowCursor

            }

            onPressed: {



                root.initialX = indicator.x
                root.movable = true


                console.log("onPress")
            }

            onClicked: {
                root.movable = false
                 console.log("onRelease")

            }

            onMouseXChanged: {

                if(root.movable == true)
                {
                    if(mouseX > root.initialX)
                    {
                        indicator.x = indicator.x + Math.abs(mouseX - root.initialX)
                    }
                    else
                    {
                        indicator.x = indicator.x - Math.abs(mouseX - root.initialX)
                    }

                }
            }

        }
    }

}
