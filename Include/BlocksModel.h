#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QObject>
#include <QtSql>
#include <QAbstractListModel>
#include <QVector>
#include <QMap>
#include <QList>

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

    signals:
        void countChanged(int count);

    protected:
        QHash<int, QByteArray> roleNames() const;

    private:
        //TODO Добавить список всех изображений отдельное поле
        QVector<Block*> blocksVector;
};
}


#endif // BLOCKSMODEL_H
