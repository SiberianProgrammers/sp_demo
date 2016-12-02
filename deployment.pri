unix:!android {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

android {
    # Добавляем в проект db в каталог assets
    sqlitedb.files += $$PWD/sp_demo.db
    sqlitedb.path = /assets
    INSTALLS += sqlitedb

    # Добавляем в проект SPActivity.java
    deployment.files += $$PWD/../sp_qt_libs/android/src/sp/SpActivity.java
    deployment.path = $$system_path(/src/sp/)
    INSTALLS += deployment
}

export(INSTALLS)
