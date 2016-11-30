#include "BlocksModel.h"

struct Block {
    Block(const int id, const QVariant& blockData) : id(id) , blockData(blockData)
    { }

    int  id;
    QVariant blockData;
};

//------------------------------------------------------------------------------
sp::BlocksModel::BlocksModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

//------------------------------------------------------------------------------
int sp::BlocksModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return blocksVector.count();
}

//------------------------------------------------------------------------------
QVariant sp::BlocksModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < blocksVector.count()) {
        switch (role) {
            case 0: // "blockId"
                return blocksVector.at(index.row())->id;

            case 1: // "blockData"
                return blocksVector.at(index.row())->blockData;
        }
    }

    return QVariant();
}

//------------------------------------------------------------------------------
int sp::BlocksModel::count() const
{
    return blocksVector.count();
}

void sp::BlocksModel::appendBlock(int blockId, QVariant blockData)
{
    Block* block = new Block(blockId, blockData);
    blocksVector.append(block);
    emit countChanged(blocksVector.count());
}

//------------------------------------------------------------------------------
QHash<int, QByteArray> sp::BlocksModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(0, "blockId");
    roles.insert(1, "blockData");
    return roles;
}
