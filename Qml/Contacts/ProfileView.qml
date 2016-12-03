import QtQuick 2.8
import SP 1.0

import "../"
import "qrc:/SpQml"

//--------------------------------------------------------------------------
// Экран списка контактов
//--------------------------------------------------------------------------
Rectangle {
    id: _profileView

    property int index: 0
    property real c0: Math.pow((photo.height - photoContainer.height)/(photo.height - Consts.statusBarHeight), 2)
    
    z: actionBar.z

    y: -Consts.statusBarHeight
    width: parent.width
    height: root.height

    //--------------------------------------------------------------------------
    // Защита от нажатия нижелаежайших элементов
    //--------------------------------------------------------------------------
    MouseArea {
        anchors.fill: parent
        onClicked: {  }
    }

    //--------------------------------------------------------------------------
    // Список данных о пользователе
    //--------------------------------------------------------------------------
    ListView {
        id: profileListView

        model: ListModel {
            ListElement { name: "1" }
            ListElement { name: "1" }
            ListElement { name: "1" }
            ListElement { name: "1" }
        }

        delegate: ProfileDelegate { }

        boundsBehavior: ListView.StopAtBounds
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        header: Item {
            width: _profileView.width
            height: photo.height + nameContainer.height + Consts.margin
        }
    }

    //--------------------------------------------------------------------------
    // Кнопка назад
    //--------------------------------------------------------------------------
    BackButton {
        id: backButton
        arrowColor: "white"
        z: nameContainer.z + 1
        y: Consts.statusBarHeight

        Connections {
            id: backKeyConnections

            target: root.keysHandler
            onBackKeyPressed: {
                if (!context.accepted) {
                    context.accepted = true;
                    backAction();
                }
            }
        }

        onClicked: {
            backAction();
        }
    } // BackButton {

    //--------------------------------------------------------------------------
    // Фотография контакта
    //--------------------------------------------------------------------------
    Item {
        id: photoContainer

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: nameContainer.top
        }
        clip: true

        ImageSp {
            id: photo

            source: "qrc:/Contacts/Profiles/Profile0.jpg"
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 0.5*(photoContainer.height-height)
            }
            height: Math.ceil(Math.min(0.4*_profileView.height, 50*mm))

            //----------------------------------------------------------------------
            ShadowTop {
                id: shadow

                anchors.bottom: parent.bottom
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Consts.contactColor
            opacity: c0
        }
    }

    //--------------------------------------------------------------------------
    // Имя, должностью и компания (оранжевая полоса)
    //--------------------------------------------------------------------------
    Rectangle {
        id: nameContainer

        color: Consts.contactColor
        anchors {
            left: parent.left
            right: parent.right
        }
        y: Math.min(Math.max(photo.height + (profileListView.originY - profileListView.contentY+1), Consts.statusBarHeight), photo.height)
        height: companyView.text != ""
                ? Math.ceil(Consts.fontBigHeight + Consts.fontNormalHeight)
                : Math.ceil(Consts.fontBigHeight + 2*Consts.margin)

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: isDesktop
                                      ? -0.12*nameView.height
                                      : 0
            }

            Text {
                id: nameView

                readonly property real x0: (parent.width - contentWidth)/2
                readonly property real x1: backButton.width-(backButton.width+Consts.margin)/2
                readonly property real s1: (contentWidth-nameMinMetrics.contentWidth)/contentWidth
                text: "Михаил Серебренников"
                color: "white"
                font {
                    pixelSize: Consts.fontBig
                    weight: Font.Medium
                }
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Consts.fontSmall
                elide: Text.ElideRight
                height: contentHeight
                width: parent.width - Consts.margin
                scale: 1-c0*s1
                x: x0 + c0*x1

                Text {
                    id: nameMinMetrics

                    text: nameView.text
                    visible: false
                    width: parent.width - Consts.margin - backButton.width
                    font {
                        pixelSize: Consts.fontBig
                        weight: Font.Medium
                    }
                    elide: Text.ElideRight
                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: Consts.fontSmall
                }
            } // Text { id: nameView

            Text {
                id: companyView

                text: "директор, «Сибирские Программисты»"
                color: "white"
                visible: text != ""
                height: text != "" ? contentHeight : 0
                opacity: 0.8
                font {
                    pixelSize: Consts.fontNormal
                    weight: Font.Medium
                }
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Consts.fontSmall
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    left: parent.left
                    right: parent.right
                }
            } // Text { id: companyView
        } // Column { id: column
    } // Rectangle { id: nameContainer

    //--------------------------------------------------------------------------
    Item {
        id: statesItem

        state: "hidden"
        states: [
            State {
                name: "hidden"

                PropertyChanges {
                    target: _profileView
                    visible: false
                }
                PropertyChanges {
                    target: backKeyConnections
                    enabled: false
                }
            }
            ,State {
                name: "view"

                PropertyChanges {
                    target: _profileView
                    visible: true
                }
                PropertyChanges {
                    target: backKeyConnections
                    enabled: true
                }
            }
            ,State {
                name: "edit"

                PropertyChanges {
                    target: _profileView
                    visible: true
                }
                PropertyChanges {
                    target: backKeyConnections
                    enabled: true
                }
            }
        ]
    } // Item { id: statesItem

    //--------------------------------------------------------------------------
    function backAction() {
        if (statesItem.state === "edit") {
            cancelEdit();
        } else {
            hide();
        }
    }

    //--------------------------------------------------------------------------
    // Переводит профиль в режим редактирования
    //--------------------------------------------------------------------------
    function edit(index) {
        if (index === undefined) {
            index = _profileView.index;
        } else {
            _profileView.index = index;
        }

        statesItem.state = "edit";
    }

    //--------------------------------------------------------------------------
    // Выходит из режима редактирования без сохраниня изменений
    //--------------------------------------------------------------------------
    function cancelEdit() {
        statesItem.state = "view";
    }

    //--------------------------------------------------------------------------
    // Скрывает профиль
    //--------------------------------------------------------------------------
    function hide() {
        statesItem.state = "hidden";
    }

    //--------------------------------------------------------------------------
    // Показывает профиль с указанным индексом
    //--------------------------------------------------------------------------
    function show(index) {
        _profileView.index = index;
        statesItem.state = "view";
    }
}
