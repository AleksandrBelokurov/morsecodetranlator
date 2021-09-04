import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.1

ApplicationWindow {
    visible: true
    width: 640
    minimumWidth: 320
    height: 480
    minimumHeight: 320
    font.pixelSize: Qt.application.font.pixelSize * 1.5
    title: qsTr("Morse code tranlator")

    function openFile(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        return request.responseText;
    }

    function saveFile(fileUrl, text) {
        var request = new XMLHttpRequest();
        request.open("PUT", fileUrl, false);
        request.send(text);
        return request.status;
    }

    FileDialog {
        id: openFileDialog
        nameFilters: ["Text files (*.txt)", "All files (*)"]
        onAccepted: textToTranslate.text = openFile(openFileDialog.fileUrl)
    }

    FileDialog {
        id: saveFileDialog
        selectExisting: false
        nameFilters: ["Text files (*.txt)", "All files (*)"]
        onAccepted: saveFile(saveFileDialog.fileUrl, textTranslated.text)
    }

    ScrollView {
        anchors.fill: parent

        Label {
            id: labelInputText
            x: 5
            y: 5
            text: qsTr("Input data:")
        }

        Button {
            id: btnInputText
            anchors.top: labelInputText.bottom
            anchors.left: labelInputText.left
            anchors.topMargin: 5
            text: qsTr("Open file")
            onClicked: openFileDialog.open()
        }

        Rectangle {
            id: recToTranslate
            border.width: 1
            border.color: "black"
            height: parent.height * 0.4
            width: parent.width - btnInputText.width - 15
            anchors.top: labelInputText.top
            anchors.left: btnInputText.right
            anchors.leftMargin: 5

            ScrollView {
                id: view
                anchors.fill: parent
                TextArea {
                    id: textToTranslate
                    objectName: "textToTranslate"
                    wrapMode: TextEdit.Wrap
                    selectByMouse: true
                    text: qsTr("Text to translate would be here")
                    onTextChanged: {
                        if (textToTranslate.text.search(/^[ .-]*$/) < 0) {
                            labelStatusBar.text = qsTr("Input text type not looks like morse code")
                            labelStatusBar.color = "black"
                        } else {
                            labelStatusBar.text = qsTr("Input text type looks like morse code")
                            labelStatusBar.color = "darkgreen"
                        }
                        switch (cbCommand.currentIndex) {
                        case 0:
                            textTranslated.text = Translator.encodeMorse(textToTranslate.text)
                            break;
                        case 1:
                            textTranslated.text = Translator.decodeMorse(textToTranslate.text)
                            break;
                        default:
                            break;
                        }
                    }
                }
            }
        }

        Button {
            id: buttonTranslate
            anchors.top: recToTranslate.bottom
            anchors.left: recToTranslate.left
            anchors.topMargin: 5
            text: qsTr("Translate")
            onClicked: {
                switch (cbCommand.currentIndex) {
                case 0:
                    textTranslated.text = Translator.encodeMorse(textToTranslate.text)
                    break;
                case 1:
                    textTranslated.text = Translator.decodeMorse(textToTranslate.text)
                    break;
                default:
                    break;
                }
            }
        }

        ComboBox {
            id: cbCommand
            model: ["ascii text to morse code", "morse code to ascii text"]
            width: recToTranslate.width - buttonTranslate.width - 5
            anchors.top: buttonTranslate.top
            anchors.left: buttonTranslate.right
            anchors.leftMargin: 5
        }

        Rectangle {
            id: recTranslated
            border.width: 1
            border.color: "black"
            height: parent.height * 0.4
            width: recToTranslate.width
            anchors.top: buttonTranslate.bottom
            anchors.left: buttonTranslate.left
            anchors.topMargin: 5
            ScrollView {
                anchors.fill: parent
                TextArea {
                    id: textTranslated
                    objectName: "textTranslated"
                    selectByMouse: true
                    text: qsTr("Morse code would be here")
                    wrapMode: TextArea.Wrap
                }
            }
        }

        Label {
            id: labelOutputText
            anchors.top: recTranslated.top
            anchors.left: labelInputText.left
            text: qsTr("Output:")
        }

        Button {
            text: "Save file"
            anchors.top: labelOutputText.bottom
            anchors.left: labelOutputText.left
            anchors.topMargin: 5
            onClicked: saveFileDialog.open()
        }

    }

    footer: Label {
        id: labelStatusBar
        text: qsTr("Input text looks like")
    }
}
