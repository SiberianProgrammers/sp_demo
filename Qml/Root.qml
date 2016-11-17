import QtQuick 2.7
import SP 1.0

import "./"
import "qrc:/SpQml"
import "qrc:/Components"

Item {
    id: root

    readonly property alias toast: toast
    readonly property alias keysHandler: keysHandler

    width: Window.width
    height: Window.height
    Keys.forwardTo: keysHandler

    KeysHandler { id: keysHandler }
    Toast       { id: toast }
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
                    x: -0.5*rootContainer.width
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
