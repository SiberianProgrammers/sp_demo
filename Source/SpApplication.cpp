#include <LogSp.h>
#include "SpApplication.h"
#include "JournalDb.h"
#include "ArticlesPreviewModel.h"
#include "ArticleBlocksModel.h"
#include "BlocksModel.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#endif

sp::SpApplication::SpApplication(int &argc, char **argv, const QString &title, int width, int height)
    : SpApplicationPrototype (argc, argv, title, width, height)
{
    LOG_INFO("openSpDemoDb!!!!");
    if (sp::openSpDemoDb()) {
        LOG_INFO("Открыли SQLite");

        qmlRegisterType<sp::ArticlesPreviewModel>("SP", 1, 0, "ArticlesPreviewModel");
        qmlRegisterType<sp::ArticleBlocksModel>("SP", 1, 0, "ArticleBlocksModel");
        qmlRegisterUncreatableType<sp::BlocksModel> ("SP", 1, 0, "BlocksModel",  ("Нельзя создавать объект типа BlocksModel"));
    } else {
        LOG_ERROR("Произошла ошибка при открытии БД.");
    }

    #ifdef Q_OS_ANDROID
    QObject::connect(view(), SIGNAL(afterRendering()), this, SLOT(closeSplashScreen()));
    #endif
}

void sp::SpApplication::closeSplashScreen()
{
    #ifdef Q_OS_ANDROID
    if (firstRendering) {
        firstRendering = false;
        QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative",
                                                                               "activity", "()Landroid/app/Activity;");
        activity.callMethod<void>("finishSplash","()V");
    }
    #endif
}
