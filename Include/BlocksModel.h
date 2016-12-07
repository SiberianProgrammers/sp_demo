#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QObject>
#include <QtSql>
#include <QAbstractListModel>
#include <QVector>
#include <QMap>
#include <QList>

class ArticleBlocksModel;

struct Block;

namespace sp {

class BlocksModel: public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY (int count READ count NOTIFY countChanged)

    public:
        BlocksModel(QObject *parent = NULL);

        int rowCount (const QModelIndex & parent = QModelIndex()) const;
        QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;

        int count() const;

        void appendBlock(int blockId, QVariant blockData);
        void appendImage(const QString& image);
        Q_INVOKABLE QList<QString> getImagesList();

    signals:
        void countChanged(int count);

    protected:
        QHash<int, QByteArray> roleNames() const;

    private:
        //TODO Добавить список всех изображений отдельное поле
        QVector<Block*> blocksVector;
        QList<QString> imagesList;
};
}


#endif // BLOCKSMODEL_H
