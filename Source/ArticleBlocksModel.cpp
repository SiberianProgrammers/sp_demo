#include "ArticleBlocksModel.h"

sp::ArticleBlocksModel::ArticleBlocksModel(QObject *parent)
    : QObject(parent)
{
    itemTable = new QSqlRelationalTableModel(this);
    itemTable->setTable("journal");
    itemTable->select();
}

//------------------------------------------------------------------------------
sp::BlocksModel* sp::ArticleBlocksModel::getBlocksModel(int index)
{
    _currentArticleIndex = index;

    if (!blocksModelMap.contains(index)) {
        BlocksModel* blocksModel = new BlocksModel();
        blocksModelMap.insert(index, blocksModel);

        // Производим разбор блоков
        QSqlRecord record = itemTable->record(index);
        QString blocks = record.value("blocks").toString();
        int i = 0;

        while ( i < blocks.length()) {
            int blockLength = blocks.left(4).toInt();
            int blockId   = blocks.mid(4,2).toInt();
            QString block = blocks.mid(infoBlockLength,blockLength);
            blocks.remove(0, blockLength+infoBlockLength);

            QStringList splitString = block.split(_separator);
            QStringList::iterator i;
            QList<QString> partList;

            switch (blockId) {
                case Blocks::Caption:
                case Blocks::Text:
                case Blocks::Summary:
                case Blocks::Date:
                case Blocks::Author:
                    blocksModel->appendBlock(blockId, QVariant(block));
                    break;

                case Blocks::Image:
                case Blocks::QuoteSmal:
                case Blocks::QuoteLarge:
                case Blocks::NumberedList:
                case Blocks::EnumList:
                    for (i = splitString.begin(); i != splitString.end(); ++i) {
                        partList.append(*i);
                    }
                    blocksModel->appendBlock(blockId, QVariant(partList));
                    break;

                default:
                    blocksModel->appendBlock(-1, QVariant());
                break;
            }
        }
        return blocksModel;
    }

    return blocksModelMap.value(index);
}
