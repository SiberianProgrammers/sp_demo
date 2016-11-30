#include "ArticlesPreviewModel.h"

sp::ArticlesPreviewModel::ArticlesPreviewModel(QObject *parent)
    : QAbstractListModel(parent)
{
    itemTable = new QSqlRelationalTableModel(this);
    itemTable->setTable("journal");
    itemTable->select();

    int itemCount = itemTable->rowCount();
    for (int i = 0; i < itemCount; ++i) {
        QVector<QString> *article = new QVector<QString>;
        QSqlRecord record = itemTable->record(i);
        article->append(record.value("id").toString());
        article->append(record.value("imagesource").toString());
        article->append(record.value("caption").toString());
        article->append(record.value("summary").toString());
        databaseHash.insert(i, article);
    }
}

//------------------------------------------------------------------------------
int sp::ArticlesPreviewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return itemTable->rowCount();
}

//------------------------------------------------------------------------------
QVariant sp::ArticlesPreviewModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < itemTable->rowCount()){
        switch (role) {
            case 0: // "id"
                return databaseHash.value(index.row())->at(0);

            case 1: // "imageSource"
                return databaseHash.value(index.row())->at(1);

            case 2: // "caption"
                return databaseHash.value(index.row())->at(2);

            case 3: // "summary"
                return databaseHash.value(index.row())->at(3);
        }
    }

    return QVariant();
}

//------------------------------------------------------------------------------
int sp::ArticlesPreviewModel::count() const
{
    return itemTable->rowCount();
}

//------------------------------------------------------------------------------
QHash<int, QByteArray> sp::ArticlesPreviewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(0, "id");
    roles.insert(1, "imageSource");
    roles.insert(2, "caption");
    roles.insert(3, "summary");

    return roles;
}
