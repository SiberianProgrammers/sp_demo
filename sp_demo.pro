TEMPLATE = app

QT += qml quick widgets multimedia sql
CONFIG += c++11

include(Programmer.pri)
include(Deployment.pri)
include($$PWD/../sp_qt_libs/sp_qt_libs.pri)

INCLUDEPATH += Include
HEADERS += \
    Include/SpApplication.h \
    Include/JniSetup.h \
    Include/Consts.h \
    Include/JournalDb.h \
    Include/ArticlesPreviewModel.h \
    Include/ArticleBlocksModel.h \
    Include/BlocksModel.h

SOURCES += Source/Main.cpp \
    Source/SpApplication.cpp \
    Source/JniSetup.cpp \
    Source/ArticlesPreviewModel.cpp \
    Source/ArticleBlocksModel.cpp \
    Source/BlocksModel.cpp

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
        Android/AndroidManifest.xml \
        Android/gradle/wrapper/gradle-wrapper.jar \
        Android/gradlew \
        Android/res/values/libs.xml \
        Android/build.gradle \
        Android/gradle/wrapper/gradle-wrapper.properties \
        Android/gradlew.bat \
        Android/src/com/sp/demo/SpDemoActivity.java \
        Android/res/drawable/splash.xml

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../sp_demo/Android
}

DISTFILES += \
