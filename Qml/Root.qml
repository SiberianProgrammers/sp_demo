import QtQuick 2.8
import SP 1.0

import "./"
import "qrc:/SpQml"
import "qrc:/Components"

Item {
    id: root

    readonly property alias statusBar: statusBar
    readonly property alias keysHandler: keysHandler
    readonly property alias toast: toast

    Keys.forwardTo: keysHandler

    width: Window.width
    height: Window.height

    ListModel { id: demoAppsModel }
    StatusBar { id: statusBar }
    KeysHandler { id: keysHandler }
    Toast       { id: toast }

    Background {
        id: background
        anchors.fill: screenOfChoice
    }
    //--------------------------------------------------------------------------
    // Экран выбора примера приложения
    //--------------------------------------------------------------------------
    ScreenOfChoice {
        id: screenOfChoice
    }

    //--------------------------------------------------------------------------
    // Загрузчик примера приложения
    //--------------------------------------------------------------------------
    Loader {
        id: demoAppLoader

        property int currentIndex: -1

        width: root.width
        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: Consts.statusBarHeight
        }
    }

    //--------------------------------------------------------------------------
    Item {
        id: statesItem

        state: "screenOfChoise"
        states: [
            State {
                name: "screenOfChoise"
                PropertyChanges {
                    target: screenOfChoice
                    x: 0
                    visible: true
                }
                PropertyChanges {
                    target: demoAppLoader
                    x: root.width
                    visible: false
                }
            }
            , State {
                name: "demoApp"
                PropertyChanges {
                    target: screenOfChoice
                    x: -screenOfChoice.width/3
                    //visible: false
                }
                PropertyChanges {
                    target: demoAppLoader
                    x: 0
                    visible: true
                }
            }
        ]

        //--------------------------------------------------------------------------
        transitions: [
            Transition {
                from: "screenOfChoise"
                to: "demoApp"
                reversible: true

                SequentialAnimation {
                    PropertyAction {
                        target: demoAppLoader
                        property: "visible"
                    }
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        properties: "x"
                        duration: 300
                    }
                    PropertyAction {
                        target: screenOfChoice
                        property: "visible"
                    }
                }
            }
        ] // transitions: [
    } // Item { id: statesItem

    //--------------------------------------------------------------------------
    function goTo (index) {
        demoAppLoader.currentIndex = index

        if (index === -1) {
            statesItem.state = "screenOfChoise";
        } else {
            demoAppLoader.source = demoAppsModel.get(index).source
            statesItem.state = "demoApp";
        }
    }

    //--------------------------------------------------------------------------
    Component.onCompleted: {
        //demoAppsModel.append({ text: qsTr("Камера"),         source: "qrc:/Camera/Camera.qml" });
        demoAppsModel.append({ text: qsTr("Онлайн журнал"),  source: "qrc:/Journal/Journal.qml" });
        demoAppsModel.append({ text: qsTr("Список контаков"),source: "qrc:/Contacts/Contacts.qml" });
    }
}
