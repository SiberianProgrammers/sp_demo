#include <LogSp.h>
#include "SpApplication.h"
#include "JournalDb.h"
#include "ArticlesPreviewModel.h"
#include "ArticleBlocksModel.h"
#include "BlocksModel.h"

sp::SpApplication::SpApplication(int &argc, char **argv, const QString &title, int width, int height)
    : SpApplicationPrototype (argc, argv, title, width, height)
{
    if (sp::openSpDemoDb()) {
        LOG_INFO("Открыли SQLite");

        qmlRegisterType<sp::ArticlesPreviewModel>("SP", 1, 0, "ArticlesPreviewModel");
        qmlRegisterType<sp::ArticleBlocksModel>("SP", 1, 0, "ArticleBlocksModel");
        qmlRegisterUncreatableType<sp::BlocksModel> ("SP", 1, 0, "BlocksModel",  ("Нельзя создавать объект типа BlocksModel"));
    } else {
        LOG_ERROR("Произошла ошибка при открытии БД.");
    }
}
