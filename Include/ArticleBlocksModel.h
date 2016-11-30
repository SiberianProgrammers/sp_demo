#ifndef ARTICLEBLOCKSMODEL_H
#define ARTICLEBLOCKSMODEL_H

#include <QObject>
#include <QtSql>
#include <QAbstractListModel>
#include <QVector>
#include <QMap>
#include <QList>

#include "BlocksModel.h"

namespace sp {

class ArticleBlocksModel: public QObject
{
    Q_OBJECT

    public:
        enum Blocks {
            Caption        = 0 // Заголовок
            , Text         = 1 // Обычный текст
            , Summary      = 2 // Краткое содержание
            , Image        = 3 // Изображение
            , Date         = 4 // Дата
            , Author       = 5 // Автор
            , QuoteSmal    = 6 // Небольшая цитата
            , QuoteLarge   = 7 // Крупная цитата
            , NumberedList = 8 // Нумерованный список
            , EnumList     = 9 // Список-перечисление
        };

        Q_ENUM (Blocks)

    public:
        ArticleBlocksModel(QObject *parent = NULL);

        Q_INVOKABLE sp::BlocksModel* getBlocksModel(int index) ;

    private:
        QSqlRelationalTableModel *itemTable;
        QMap<int, sp::BlocksModel* > blocksModelMap;

        const QString _separator = "|$|";
        int _currentArticleIndex = -1;

};
}

#endif // ARTICLEBLOCKSMODEL_H
