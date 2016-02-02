import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import DarkStyle.Controls 1.0
import DarkStyle 1.0

Item {
    width: ListView.view ? ListView.view.width : 0
    height: 60
    clip: true
    signal imageSelected(string url)
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        anchors.margins: 2
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: imageSelected(model.url)
    }
    Rectangle {
        anchors.fill: parent
        color: {
            if(mouseArea.containsMouse)
                return Style.window.color.selected
            return Style.window.color.xdark;
        }
        opacity: 0.2
    }
    RowLayout {
        anchors.fill: parent
        spacing: 10
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: Math.min(parent.height*4/3.0, parent.width*0.4)
            color: "black"
            Image {
                anchors.fill: parent
                source: model.url
                sourceSize: Qt.size(320, 320)
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                BusyIndicator {
                    anchors.centerIn: parent
                    running: parent.status === Image.Loading
                }
            }
        }
        ColumnLayout {
            Text {
                text: model.name
                font.pixelSize: Style.text.size.small
            }
            Text {
                Layout.fillWidth: true
                text: model.url.toString().replace("file://", "")
                font.pixelSize: Style.text.size.xsmall
                color: Style.text.color.dark
                maximumLineCount: 2
            }
        }
        Item {
            Layout.fillWidth: true
        }
    }
}
