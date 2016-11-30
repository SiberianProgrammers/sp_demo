#ifndef JOURNALMODEL_H
#define JOURNALMODEL_H

#include <QObject>
#include <QtSql>
#include <QAbstractListModel>
#include <QVector>
#include <QMap>

namespace sp {

class ArticlesPreviewModel: public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY (int count READ count NOTIFY countChanged)

    public:
        ArticlesPreviewModel(QObject *parent = NULL);

        int rowCount (const QModelIndex & parent = QModelIndex()) const;
        QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;

        int count () const;

    signals:
        void countChanged(int count);

   public:
        QHash<int, QVector<QString>* > databaseHash;

    protected:
        QHash<int, QByteArray> roleNames() const;

    private:
        QSqlRelationalTableModel *itemTable;

};
}

#endif // JOURNALMODEL_H
