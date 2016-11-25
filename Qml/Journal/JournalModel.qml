import QtQuick 2.8

//--------------------------------------------------------------------------
// Модель онлайн-журнала
//--------------------------------------------------------------------------
ListModel {
    id: _journalModel

    Component.onCompleted: {
        //TODO возможно сделать element {
        // blocks: [
        //  0: ...
        //  1: ... ]
        //}

        var element = {
               header: "«Дождь»: Кремль отказался от идеи досрочных выборов после победы Трампа"
              , imageHeader: "qrc:/Journal/trump.jpg"
              , content: "Администрация президента РФ рассматривала вариант переноса президентских выборов на весну 2017 года,
однако после поражения Хиллари Клинтон на выборах президента США отказалась от этой идеи.
Об этом сообщает «Дождь» со ссылкой на источники в администрации президента.
<br><br>
По словам собеседников телеканала, вариант переноса выборов рассматривался на случай победы Хиллари Клинтон,
поскольку ее администрация, как полагали в Кремле, могла пытаться «раскачать» ситуацию в стране накануне 2018 года.
«Она бы вселилась в Белый дом только в начале следующего года, и к весне ее администрация ничего не успела бы сделать», — объяснил источник.
<br><br>
После победы Дональда Трампа в Кремле «опасений по поводу вмешательства США в российские выборы куда меньше», пишет «Дождь».
<br><br>
Другим аргументом в пользу досрочных выборов было возможное снижение рейтинга Владимира Путина из-за ухудшения экономической ситуации в России,
однако и эту ситуацию, по данным телеканала, в администрации президента сейчас не считают вероятной."
        }

        for (var i = 0; i < 10; ++i) {
            _journalModel.append(element)
        }

    } // Component.onCompleted: {
}
