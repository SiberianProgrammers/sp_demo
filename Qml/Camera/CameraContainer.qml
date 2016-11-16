import QtQuick 2.0
import QtMultimedia 5.6

import "../"
//--------------------------------------------------------------------------
// Онлайн журнал
//--------------------------------------------------------------------------
Rectangle {
    id: _cameraContainer

    property int currentCameraIndex: {
        for (var i in QtMultimedia.availableCameras) {
            //if (QtMultimedia.availableCameras[i].deviceId === QtMultimedia.defaultCamera.deviceId) {
            // Включаем сельфикамеру для фотографирования себя по-умолчанию
            if (QtMultimedia.availableCameras[i].deviceId !== QtMultimedia.defaultCamera.deviceId) {
                return i;
            }
        }

        return 0;
    }

    property string photoSource
    readonly property real cameraButtonsHeight: 20*mm
    readonly property real previewButtonsHeight: 12*mm

    color: "black"

    //--------------------------------------------------------------------------
    // Кнопка "Закрыть" без получения фотографии
    //--------------------------------------------------------------------------
    Image {
        id: crossButton

        anchors {
            top: parent.top
            right: parent.right
            margins: Consts.margin
            topMargin: Consts.statusBarHeight + Consts.margin
        }

        width : 4*mm
        height: width
        source: "qrc:/Camera/Cross.png"

        MouseArea {
            anchors {
                fill: parent
                margins: -Consts.margin
            }
            onClicked: {
                root.goTo(-1)
            }
        }
    } // Image { id: cross

    //--------------------------------------------------------------------------
    Camera {
        id: camera

        deviceId: QtMultimedia.availableCameras[currentCameraIndex].deviceId
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        flash.mode: Camera.FlashAuto
        imageCapture {
            onImageCaptured: {
                previewPhoto.source = preview;  // Show the preview in an Image
                statesItem.state = "preview";
                camera.stop();
            }
        }

        onCameraStatusChanged: {
            if (camera.cameraStatus === Camera.ActiveStatus && statesItem.state != "camera") {
                statesItem.state = "camera";
            }
        }
    } // Camera { id: camera

    //--------------------------------------------------------------------------
    // Отображение того, что сейчас снимает камера
    //--------------------------------------------------------------------------
    VideoOutput {
        id: videoOutput

        source: camera
        focus : visible // to receive focus and capture key events when visible
        autoOrientation: true
        fillMode: VideoOutput.PreserveAspectCrop
        anchors {
            top: crossButton.bottom
            left: parent.left
            right: parent.right
            bottom: backButton.top
            topMargin: Consts.margin
        }
    } // VideoOutput { id: videoOutput

    //--------------------------------------------------------------------------
    // Кнопка "Вспышка"
    //--------------------------------------------------------------------------
    MouseArea {
        id: flashButton

        enabled: !cooldownTimer.running
        width: parent.width/3
        height: cameraButtonsHeight
        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
        }

        Image {
            id: flashImage

            anchors.centerIn: parent
            width: 5*mm
            height: width
        }

        state: QtMultimedia.availableCameras[currentCameraIndex].position !== 2
               ? "auto"
               : "invisible"
        states: [
            State {
                name: "blocked"
                PropertyChanges {
                    target: flashImage
                    source: "qrc:/Camera/FlashOff.png"
                }
                PropertyChanges {
                    target: flashButton
                    enabled: false
                }
            }
            ,State {
                name: "off"
                PropertyChanges {
                    target: flashImage
                    source: "qrc:/Camera/FlashOff.png"
                }
            }
            ,State {
                name: "on"
                PropertyChanges {
                    target: flashImage
                    source: "qrc:/Camera/FlashOn.png"
                }
            }
            ,State {
                name: "auto"
                PropertyChanges {
                    target: flashImage
                    source: "qrc:/Camera/FlashAuto.png"
                }
            }
        ] // states: [

        onClicked: {
            switch (camera.flash.mode) {
                case Camera.FlashAuto:
                    state = "on";
                    camera.flash.mode = Camera.FlashOn;
                    break;
                case Camera.FlashOn:
                    state = "off";
                    camera.flash.mode = Camera.FlashOff;
                    break;
                case Camera.FlashOff:
                default:
                    state = "auto";
                    camera.flash.mode = Camera.FlashAuto;
                    break;
            }
        } // onClicked: {
    } // MouseArea { id: flashButton

    //--------------------------------------------------------------------------
    // Кнопка съёмки фотографии
    //--------------------------------------------------------------------------
    MouseArea {
        id: shootButton

        enabled: !cooldownTimer.running
        width: parent.width/3
        height: cameraButtonsHeight
        anchors {
            left: flashButton.right
            bottom: parent.bottom
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
        }

        Image {
            source: shootButton.pressed
                    ? "qrc:/Camera/ShootPressed.png"
                    : "qrc:/Camera/Shoot.png"
            anchors.centerIn: parent
            width: 15*mm
            height: width
        }

        onClicked: {
            camera.imageCapture.capture();
            cooldownTimer.start();
        }
    } // MouseArea { id: shootButton

    //--------------------------------------------------------------------------
    // Кнпока переключения камер с фронтальной на заднюю и обратно
    //--------------------------------------------------------------------------
    MouseArea {
        id: switchCameraButton

        enabled: !cooldownTimer.running && QtMultimedia.availableCameras.length > 1
        width: parent.width/3
        height: cameraButtonsHeight
        anchors {
            left: shootButton.right
            bottom: parent.bottom
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
        }

        Image {
            source: "qrc:/Camera/SwitchCamera.png"
            anchors.centerIn: parent
            width: 6*mm
            height: width
            visible: QtMultimedia.availableCameras.length > 1
        }

        onClicked: {
            currentCameraIndex = currentCameraIndex + 1 < QtMultimedia.availableCameras.length
                                 ? currentCameraIndex + 1
                                 : 0;

            flashButton.state = QtMultimedia.availableCameras[currentCameraIndex].position === 2
                                ? "blocked"
                                : "auto";

            cooldownTimer.start();
        }
    } // MouseArea { id: switchCameraButton

    //--------------------------------------------------------------------------
    // Предосмотр фотографии
    //--------------------------------------------------------------------------
    Image {
        id: previewPhoto

        fillMode: Image.PreserveAspectCrop
        visible: false
        anchors {
            top: crossButton.bottom
            left: parent.left
            right: parent.right
            bottom: backButton.top
            topMargin: Consts.margin
        }
    }

    //--------------------------------------------------------------------------
    // Кнопка возврата к режиму съемки Назад (по тапу удаляет сделанное фото)
    //--------------------------------------------------------------------------
    MouseArea {
        id: backButton

        enabled: !cooldownTimer.running
        visible: false
        width: parent.width
        height: previewButtonsHeight
        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        Text {
            text: qsTr("Назад")
            color: "white"
            font.pixelSize: Consts.fontNormal
            fontSizeMode: Text.HorizontalFit
            horizontalAlignment: Text.AlignHCenter
            anchors {
                left: parent.left
                right: parent.right
                margins: Consts.margin
                verticalCenter: parent.verticalCenter
            }
        }

        onClicked: {
            backFromPreview();
        }
    } // MouseArea { id: backButton

    ////--------------------------------------------------------------------------
    //// Загрузить фото Загрузить (по тапу открывает предупреждающий попап с ценой загрузки/бесплатной загрузкой)
    ////--------------------------------------------------------------------------
    //MouseArea {
    //    id: acceptButton
    //
    //    enabled: !cooldownTimer.running
    //    visible: false
    //    width: parent.width/2
    //    height: previewButtonsHeight
    //    anchors {
    //        right: parent.right
    //        bottom: parent.bottom
    //    }
    //
    //    Text {
    //        text: qsTr("Загрузить")
    //        color: "white"
    //        font {
    //            bold: true
    //            pixelSize: Consts.fontBig
    //        }
    //        minimumPixelSize: Consts.fontTiny
    //        fontSizeMode: Text.HorizontalFit
    //        horizontalAlignment: Text.AlignHCenter
    //        anchors {
    //            left: parent.left
    //            right: parent.right
    //            margins: Consts.margin
    //            verticalCenter: parent.verticalCenter
    //        }
    //    }
    //
    //    onClicked: {
    //        photoSource = previewPhoto.source.toString();
    //    }
    //} // MouseArea { id: acceptButton

    //--------------------------------------------------------------------------
    Timer {
        id: cooldownTimer

        interval: 500
    }

    //--------------------------------------------------------------------------
    Item {
        id: statesItem

        state: "camera"
        states: [
            State {
                name: "camera"
            }
            ,State {
                name: "preview"

                PropertyChanges {
                    target: previewPhoto
                    visible: true
                }
                PropertyChanges {
                    target: backButton
                    visible: true
                }
                //PropertyChanges {
                //    target: acceptButton
                //    visible: true
                //}
                PropertyChanges {
                    target: videoOutput
                    visible: false
                }
                PropertyChanges {
                    target: flashButton
                    visible: false
                }
                PropertyChanges {
                    target: shootButton
                    visible: false
                }
                PropertyChanges {
                    target: switchCameraButton
                    visible: false
                }
            }
        ] // states: [
    } // Item { id: statesItem

    //--------------------------------------------------------------------------
    function backFromPreview() {
        camera.start();
        cooldownTimer.start();
    }



}
