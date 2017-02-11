import QtQuick 2.7
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3

ApplicationWindow
{
    property var ms: 0 //milliseconds
    property var s:0   //seconds
    property var m:0   //minutes
    property var lap:0

    visible: true
    width: 640
    height: 480
    title: qsTr("Simple Timer")

    Item
    {
        Timer
        {
            id:simpleTimer
            interval: 20; running: false; repeat: true
            onTriggered:
            {
                ms=ms+20
                if(ms>=1000)
                {
                    s=s+1
                    ms=0
                    if(s>=60)
                    {
                        m=m+1
                        s=0
                    }
                }
                if(s<10)
                lablTimer.text = m+":0"+s.toString()+":"+ms.toString()
                else lablTimer.text =m+":"+s.toString()+":"+ms.toString()
            }
         }
    }

    ColumnLayout
    {
       anchors.centerIn: parent
       Label
       {
           id : lablTimer
           text: qsTr("0:00:000")
           anchors.horizontalCenter: parent.horizontalCenter
           font.pixelSize: 30
       }

        RowLayout
        {
            Button
            {
                id: buttStart
                text: qsTr("Start")
                onClicked:
                {
                    buttStop.enabled=true
                    buttnewLine.enabled=true
                    buttnewLine.text = qsTr("Lap")

                    //pause or start
                    if(simpleTimer.running==false)
                     {
                        buttStart.text= qsTr("Pause")
                        simpleTimer.running =true
                     }
                    else
                    {
                        buttStart.text=  qsTr("Start")
                        simpleTimer.running =false
                    }
                }
            }

            Button
            {
                id: buttStop
                enabled: false
                text: qsTr("Stop")
                onClicked:
                {
                    if(lapTextArea.text!="")
                        buttnewLine.text = qsTr("Clear all laps")
                    else buttnewLine.enabled = false

                    buttStop.enabled = false
                    buttStart.text = "Start"

                    simpleTimer.stop()
                    lablTimer.text="0:00:000"
                    ms=0
                    s=0
                    m=0
                }
            }

            Button
            {
                    id: buttnewLine
                    enabled: false
                    text: qsTr("Lap")
                    onClicked:
                    {
                        //clear all laps
                        if(buttStop.enabled == false)
                        {
                            lapTextArea.text=""
                            lap=0
                            buttnewLine.enabled = false
                        }
                        //add lap to textedit
                        else
                        {
                            lap++
                            if(lablTimer.text!="0:00:000")
                            {
                                if(s<10)
                                lapTextArea.append(lap+". "+m+":0"+s.toString()+":"+ms.toString())
                                else lapTextArea.append(lap+". "+m+":"+s.toString()+":"+ms.toString())
                            }
                        }
                    }
             }

         }
            TextArea
            {
                id:lapTextArea
                readOnly: true
                font.pixelSize: 22
            }
    }
}

