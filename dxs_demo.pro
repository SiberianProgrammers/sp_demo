TEMPLATE = app

QT += qml quick widgets
CONFIG += c++11

include(Programmer.pri)
include(Deployment.pri)
include($$PWD/../dxs_qt_libs/dxs_qt_libs.pri)

INCLUDEPATH += Include
HEADERS += \
    Include/DxsApplication.h

SOURCES += Source/Main.cpp \
    Source/DxsApplication.cpp

RESOURCES += \
    $$PWD/Qml/qml.qrc

android {
    QT += androidextras

    DISTFILES += \
        ../dxs_demo/Android/AndroidManifest.xml \
        ../dxs_demo/Android/gradle/wrapper/gradle-wrapper.jar \
        ../dxs_demo/Android/gradlew \
        ../dxs_demo/Android/res/values/libs.xml \
        ../dxs_demo/Android/build.gradle \
        ../dxs_demo/Android/gradle/wrapper/gradle-wrapper.properties \
        ../dxs_demo/Android/gradlew.bat \
        ../dxs_demo/Android/src/com/dxs/demo/DxsDemoActivity.java

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../dxs_demo/Android
}
