TEMPLATE = app

QT += qml quick widgets multimedia
CONFIG += c++11

include(Programmer.pri)
include(Deployment.pri)
include($$PWD/../sp_qt_libs/sp_qt_libs.pri)

INCLUDEPATH += Include
HEADERS += \
    Include/SpApplication.h \
    Include/JniSetup.h \
    Include/Consts.h

SOURCES += Source/Main.cpp \
    Source/SpApplication.cpp \
    Source/JniSetup.cpp

RESOURCES += \
    $$PWD/Qml/qml.qrc \
    Images/images.qrc \
    Fonts/fonts.qrc \
    Qml/Camera/camera.qrc \
    Qml/Journal/journal.qrc \
    Qml/Contacts/contacts.qrc \
    Qml/Components/components.qrc

android {
    QT += androidextras

    DISTFILES += \
        ../sp_demo/Android/AndroidManifest.xml \
        ../sp_demo/Android/gradle/wrapper/gradle-wrapper.jar \
        ../sp_demo/Android/gradlew \
        ../sp_demo/Android/res/values/libs.xml \
        ../sp_demo/Android/build.gradle \
        ../sp_demo/Android/gradle/wrapper/gradle-wrapper.properties \
        ../sp_demo/Android/gradlew.bat \
        ../sp_demo/Android/src/com/sp/demo/SpDemoActivity.java

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../sp_demo/Android
}

DISTFILES +=
