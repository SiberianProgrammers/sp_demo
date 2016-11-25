import QtQuick 2.8
import SP 1.0

import "./"
import "qrc:/SpQml"
import "qrc:/Components"

Item {
    id: root

    readonly property KeysHandler keysHandler: _main.keysHandler
    readonly property Toast toast: _main.toast
    readonly property alias statusBar: statusBar

    width: Window.width
    height: Window.height

    Background  { id: background }
    ListModel   { id: demoAppsModel }

    //--------------------------------------------------------------------------
    Item {
        id: rootContainer

        width: 2*parent.width
        anchors {
            top: parent.top
            bottom: parent.bottom
        }

        //--------------------------------------------------------------------------
        ScreenOfChoice {
            id: screenOfChoice
            anchors.left: parent.left
        } // ScreenOfChoice { id: screenOfChoice

        //--------------------------------------------------------------------------
        Loader {
            id: demoAppLoader

            property int currentIndex: -1

            anchors.right: parent.right
            height: root.height
            width: root.width
        } // Loader { id: demoAppLoader

        //--------------------------------------------------------------------------
        state: "screenOfChoise"
        states: [
            State {
                name: "screenOfChoise"
                PropertyChanges {
                    target: rootContainer
                    x: 0
                }
            }
            , State {
                name: "demoApp"
                PropertyChanges {
                    target: rootContainer
                    x: -Window.width
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    properties: "x"
                    duration: 300
                }
            }
        ]
    } // Item { id: rootContainer

    StatusBar { id: statusBar }

    //--------------------------------------------------------------------------
    function goTo (index) {
        demoAppLoader.currentIndex = index
        if (index === -1) {
            rootContainer.state = "screenOfChoise"
        } else {
            demoAppLoader.source = demoAppsModel.get(index).source
            rootContainer.state = "demoApp"
        }
    }

    //--------------------------------------------------------------------------
    Component.onCompleted: {
        demoAppsModel.append({source: "qrc:/Camera/Camera.qml"})
        demoAppsModel.append({source: "qrc:/Journal/Journal.qml"})
        demoAppsModel.append({source: "qrc:/Journal/Contacts.qml"})
    }
}
