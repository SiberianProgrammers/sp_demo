#include "ArticleBlocksModel.h"

sp::ArticleBlocksModel::ArticleBlocksModel(QObject *parent)
    : QObject(parent)
{
    //TODO - вынести в отдельный поток
    itemTable = new QSqlRelationalTableModel(this);
    itemTable->setTable("journal");
    itemTable->select();
}

//------------------------------------------------------------------------------
sp::BlocksModel* sp::ArticleBlocksModel::getBlocksModel(int index)
{
    if (!blocksModelHash.contains(index)) {
        BlocksModel* blocksModel = new BlocksModel(this);
        blocksModelHash.insert(index, blocksModel);

        QSqlRecord record = itemTable->record(index);
        // Сразу добавляем в модель фото - заглавное изображение.
        QString imageSource = record.value("imagesource").toString();

        blocksModel->appendImage(imageSource);
        // Производим разбор блоков
        QString blocks = record.value("blocks").toString();
        int imagesLength = 0;
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
                case BlocksType::Caption:
                case BlocksType::Text:
                case BlocksType::Summary:
                case BlocksType::Date:
                case BlocksType::Author:
                    blocksModel->appendBlock(blockId, QVariant(block));
                    break;

                case BlocksType::Image:
                    for (i = splitString.begin(); i != splitString.end(); ++i) {
                        partList.append(*i);
                    }
                    partList.append(QString::number(++imagesLength));

                    blocksModel->appendBlock(blockId, QVariant(partList));
                    blocksModel->appendImage(partList.at(0));
                    break;

                case BlocksType::QuoteSmal:
                case BlocksType::QuoteLarge:
                case BlocksType::NumberedList:
                case BlocksType::EnumList:
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

    return blocksModelHash.value(index);
}
