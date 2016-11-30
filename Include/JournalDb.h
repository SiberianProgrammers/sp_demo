#ifndef JOURNALDB_H
#define JOURNALDB_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>

namespace sp {

static bool createJournalDb()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(":memory:");
    if (!db.open()) {
        return false;
    }

    QSqlQuery query;
    query.exec("create table journal (id int primary key"
                                    ",imagesource varchar(40)"
                                    ",caption varchar(100)"
                                    ",summary varchar(150)"
                                    ",blocks varchar(999)"
                                    ")");

    // Блоки добавлять в формате
    // XXXYYblockData, где XXX - длинна blockText, yy - id блока. Id можно посмотреть в ArticleBlocksModel
    // blockData - даннык блока. В качестве разделителя использовать |&|
    // К примеру 03509это нумерованный блок|$|1|$|2|$|3|$|4 - нумерованный блок от 1 до 4 и надписью "это нумерованный блок"

    query.exec("insert into journal"
               " values (0"
               ", 'qrc:/Journal/trump.png' "
               ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
               ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
                  " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
               ", '01800this caption block"
                    "02101this plain text block"
                    "01802this summary block"
                    "04303qrc:/Journal/trump.png|$|трам вещает народу"
                    "01504this date block"
                    "02906this quote small block|$|alex"
                    "03708this numberlist block|$|1|$|2|$|3|$|4"
                    "03509this enumlist block|$|1|$|2|$|3|$|4"
                  "'"
               ")"
               );

    query.exec("insert into journal"
               " values (1"
               ", 'qrc:/Journal/trump.png' "
               ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
               ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
                  " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
               ", '01800this caption block"
                  "02101this plain text block"
                  "01802this summary block"
                  "01504this date block"
                  "02906this quote small block|$|alex"
                  "03708this numberlist block|$|1|$|2|$|3|$|4"
                  "03509this enumlist block|$|1|$|2|$|3|$|4"
                  "'"
               ")"
               );

    query.exec("insert into journal"
               " values (2"
               ", 'qrc:/Journal/trump.png' "
               ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
               ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
                  " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
               ", '01800this caption block"
                  "02101this plain text block"
                  "01802this summary block"
                  "01504this date block"
                  "02906this quote small block|$|alex"
                  "03708this numberlist block|$|1|$|2|$|3|$|4"
                  "03509this enumlist block|$|1|$|2|$|3|$|4"
                  "'"
               ")"
               );

    query.exec("insert into journal"
               " values (3"
               ", 'qrc:/Journal/trump.png' "
               ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
               ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
                  " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
               ", '01800this caption block"
                  "02101this plain text block"
                  "01802this summary block"
                  "01504this date block"
                  "02906this quote small block|$|alex"
                  "03708this numberlist block|$|1|$|2|$|3|$|4"
                  "03509this enumlist block|$|1|$|2|$|3|$|4"
                  "'"
               ")"
               );

    query.exec("insert into journal"
               " values (4"
               ", 'qrc:/Journal/trump.png' "
               ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
               ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
                  " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
               ", '01800this caption block"
                  "02101this plain text block"
                  "01802this summary block"
                  "01504this date block"
                  "02906this quote small block|$|alex"
                  "03708this numberlist block|$|1|$|2|$|3|$|4"
                  "03509this enumlist block|$|1|$|2|$|3|$|4"
                  "'"
               ")"
               );

    return true;
}
}

#endif // JOURNALDB_H
