#ifndef JOURNALDB_H
#define JOURNALDB_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QtSql>

namespace sp {

static bool openSpDemoDb()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

#if defined(Q_OS_ANDROID)

    // Такая шарада нужна из-за того, что в assets только ReadOnly.
    QString dbPath = "assets:/sp_demo.db";
    QString dbNewPath = "./sp_demo.db";
    QFile file(dbPath);
    file.copy(dbNewPath);

    db.setDatabaseName(dbNewPath);
    return db.open();
#else
    db.setDatabaseName("sp_demo.db");
    return db.open();
#endif

    return true;
}
}



// Старый код - создание БД внутри приложения

// QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
// db.setDatabaseName(":memory:");
// if (!db.open()) {
//    return false;
// }
//    QSqlQuery query;
//    query.exec("create table journal (id int primary key"
//                                    ",imagesource varchar(40)"
//                                    ",caption varchar(100)"
//                                    ",summary varchar(150)"
//                                    ",blocks varchar(999)"
//                                    ")");

// Блоки добавлять в формате
// XXXYYblockData, где XXX - длинна blockText, yy - id блока. Id можно посмотреть в ArticleBlocksModel
// blockData - даннык блока. В качестве разделителя использовать |&|
// К примеру 03509это нумерованный блок|$|1|$|2|$|3|$|4 - нумерованный блок от 1 до 4 и надписью "это нумерованный блок"

//query.exec("insert into journal"
//           " values (0"
//           ", 'qrc:/Journal/linus.jpg' "
//           ", 'Linux исполнилось 25 лет' "
//           ", 'Время бежит очень быстро, и операционной системе Linux уже исполнилось четверть века."
//              "25 августа 1991 года, спустя пять месяцев после начала работы над своим проектом, "
//              "21-летний Линус Торвальдс (тогда еще студент) рассказал о создании прототипа совершенно новой ОС с названием Linux.'"
//           ", '4280117 сентября 1991 года состоялся первый публичный выпуск ядра Linux. Версия ядра на тот момент — 0.0.1."
//                    " Уже тогда количество строк кода ядра составляло 10 тысяч."
//                    " Размер его был всего 62 Кб в сжатом виде."
//                    " Сейчас же ядро насчитывает во много раз больше строк кода — целых 19 млн."
//                    " Если бы разработка ОС проводилась силами коммерческой организации, то стоимость такого проекта составила бы около миллиарда"
//                    " долларов США, а то и более."
//                "30106«Я очень доволен настольной версией Linux. Конечно же, я хотел, чтобы Linux захватил и мир настольных PC, но, как оказалось,"
//                    " эту область захватить очень сложно. Я по-прежнему работаю над этим. Прошло уже 25 лет. Я могу потратить на это ещё 25 лет."
//                    " Я добьюсь своего долгой осадой»,|$| — Линус Торвальдс"
//                "35101Интересно, что Linux мог бы изначально называться Freax («free», «freak» и X (Unix))."
//                    "Такое название своему проекту дал сам Линус. Но Ари Лемке (Ari Lemmke), который по просьбе Линуса выложил ядро на своем FTP-сервере,"
//                    "назвал директорию с ядром «linux». С момента своего первого релиза ядро претерпело множество преобразований. "
//                    "Вот наглядная статистика:"
//                "293090.0.1 — сентябрь 1991, 10 тыс. строк кода"
//                    "|$|1.0.0 — март 1994, 176 тыс. строк кода"
//                    "|$|2.0.0 — июнь 1996, 778 тыс. строк кода"
//                    "|$|2.6.35 — август 2010, 13.4 млн. строк кода"
//                    "|$|3.0 — август 2011, 14.6 млн. строк кода"
//                    "|$|3.16 — август 2014, 17.5 млн. строк кода"
//                    "|$|4.7 — июль 2016, 21.7 млн. строк кода"
//                "27401Что же, осталось только пожелать разработчикам этой ОС будущих успехов и признания."
//                    "Linux помогает бороться с монополистами на рынке ОС, но еще больше эта операционная система помогает в работе как компаниям,"
//                    "так и отдельным пользователям. С днем рождения, Linux! С юбилеем!"
//              "'"
//           ")"
//           );

//query.exec("insert into journal"
//           " values (0"
//           ", 'qrc:/Journal/trump.png' "
//           ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
//           ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
//              " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
//           ", '01800this caption block"
//                "02101this plain text block"
//                "01802this summary block"
//                "04303qrc:/Journal/trump.png|$|трам вещает народу"
//                "01504this date block"
//                "01705this author block"
//                "02906this quote small block|$|alex"
//                "02907this quote large block|$|alex"
//                "04606\"Knowledge itself is power\"|$| - Francis Bacon"
//                "04307\"Knowledge itself is power\"|$|Francis Bacon"
//                "03708this numberlist block|$|1|$|2|$|3|$|4"
//                "03509this enumlist block|$|1|$|2|$|3|$|4"
//              "'"
//           ")"
//           );

//query.exec("insert into journal"
//           " values (1"
//           ", 'qrc:/Journal/trump.png' "
//           ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
//           ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
//              " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
//           ", '01800this caption block"
//              "02101this plain text block"
//              "01802this summary block"
//              "01504this date block"
//              "02906this quote small block|$|alex"
//              "03708this numberlist block|$|1|$|2|$|3|$|4"
//              "03509this enumlist block|$|1|$|2|$|3|$|4"
//              "'"
//           ")"
//           );

//query.exec("insert into journal"
//           " values (2"
//           ", 'qrc:/Journal/trump.png' "
//           ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
//           ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
//              " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
//           ", '01800this caption block"
//              "02101this plain text block"
//              "01802this summary block"
//              "01504this date block"
//              "02906this quote small block|$|alex"
//              "03708this numberlist block|$|1|$|2|$|3|$|4"
//              "03509this enumlist block|$|1|$|2|$|3|$|4"
//              "'"
//           ")"
//           );

//query.exec("insert into journal"
//           " values (3"
//           ", 'qrc:/Journal/trump.png' "
//           ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
//           ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
//              " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
//           ", '01800this caption block"
//              "02101this plain text block"
//              "01802this summary block"
//              "01504this date block"
//              "02906this quote small block|$|alex"
//              "03708this numberlist block|$|1|$|2|$|3|$|4"
//              "03509this enumlist block|$|1|$|2|$|3|$|4"
//              "'"
//           ")"
//           );

//query.exec("insert into journal"
//           " values (4"
//           ", 'qrc:/Journal/trump.png' "
//           ", '«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа' "
//           ", 'Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года, "
//              " однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.'"
//           ", '01800this caption block"
//              "02101this plain text block"
//              "01802this summary block"
//              "01504this date block"
//              "02906this quote small block|$|alex"
//              "03708this numberlist block|$|1|$|2|$|3|$|4"
//              "03509this enumlist block|$|1|$|2|$|3|$|4"
//              "'"
//           ")"
//           );




#endif // JOURNALDB_H
