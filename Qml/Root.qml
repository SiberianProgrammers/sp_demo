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

    Background { id: background }
    ListModel  { id: demoAppsModel }
    StatusBar { id: statusBar }

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
            left: screenOfChoice.right
            bottom: parent.bottom
            topMargin: Consts.statusBarHeight
        }
    }

    //--------------------------------------------------------------------------
    state: "screenOfChoise"
    states: [
        State {
            name: "screenOfChoise"
            PropertyChanges {
                target: screenOfChoice
                x: 0
            }
        }
        , State {
            name: "demoApp"
            PropertyChanges {
                target: screenOfChoice
                x: -Window.width
            }
        }
    ]

    //--------------------------------------------------------------------------
    transitions: [
        Transition {
            NumberAnimation {
                easing.type: Easing.OutQuad
                properties: "x"
                duration: 300
            }
        }
    ]

    //--------------------------------------------------------------------------
    function goTo (index) {
        demoAppLoader.currentIndex = index

        if (index === -1) {
            state = "screenOfChoise"
        } else {
            demoAppLoader.source = demoAppsModel.get(index).source
            state = "demoApp"
        }
    }

    //--------------------------------------------------------------------------
    Component.onCompleted: {
        demoAppsModel.append({ text: qsTr("Камера"),         source: "qrc:/Camera/Camera.qml" });
        demoAppsModel.append({ text: qsTr("Онлайн журнал"),  source: "qrc:/Journal/Journal.qml" });
        demoAppsModel.append({ text: qsTr("Список контаков"),source: "qrc:/Contacts/Contacts.qml" });

        //Debug!!!
        goTo (1);
    }
}
