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
    $$PWD/Qml/Qml.qrc \
    Images/Images.qrc \
    Fonts/Fonts.qrc \
    Qml/Camera/Camera.qrc \
    Qml/Journal/Journal.qrc \
    Qml/Contacts/Contacts.qrc \
    Qml/Components/Components.qrc

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
        Android/src/com/sp/demo/SplashActivity.java \
        Android/res/drawable/splash.xml

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../sp_demo/Android
}

mac {
  SQLiteDb.files = $$PWD/sp_demo.db
  SQLiteDb.path  = Contents/MacOS
  QMAKE_BUNDLE_DATA += SQLiteDb
}

!mac {
    # Копирование БД в папку с билдом. БД нельзя вставить в ресурсы.
    # using shell_path() to correct path depending on platform
    # escaping quotes and backslashes for file paths
    copydata.commands = $(COPY_FILE) \"$$shell_path($$PWD\\sp_demo.db)\" \"$$shell_path($$OUT_PWD)\"
    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

DISTFILES += \
    Android/src/com/sp/demo/SpProjectPrototypeActivity.java


