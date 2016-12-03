import QtQuick 2.8

//--------------------------------------------------------------------------
// Экран списка контактов
//--------------------------------------------------------------------------
ListModel {
    id: contactsModel
    
    ListElement {
        name: "Лев Давидович Ландау"
        company: "МФТИ"
        position: "академик"
        profileData: [
            ListElement  { value: "+7(800)-0-00-00-00"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "landau@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "Баку"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "1 апреля 1968"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Лев Семёнович Понтрягин"
        company: "МГУ"
        position: "академик"
        profileData: [
            ListElement  { value: "+7(800)-800-00-01"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Москва"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "pontriagin@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "21 августа1908"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Аристотель"
        position: "философ"
        profileData: [
            ListElement  { value: "+30(800)-000-00-02"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Халкида"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "aristotel@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "384 до н. э."; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Исаак Ньютон"
        company: "Кембриджский университет"
        position: "физик"
        profileData: [
            ListElement  { value: "+44(800)-000-00-03"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Вулстхорп-бай-Колстерворт"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "newton@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "25 декабря 1642"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Алан Тьюринг"
        company: "Кембриджский университет"
        position: "математик"
        profileData: [
            ListElement  { value: "+44(800)-000-00-04"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Уилмслоу"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "turing@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "23 июня 1912"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Норма Джин Мортенсон"
        position: "актриса"
        profileData: [
            ListElement  { value: "+1(800)-000-00-05"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Лос-Анджелес"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "merilyn@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "1 июня 1926"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Юрий Алексеевич Гагарин"
        company: "СССР"
        position: "космонавт"
        profileData: [
            ListElement  { value: "+7(800)-000-00-06"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Клушино"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "gagarin@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "9 марта 1932"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Нил Армстронг"
        company: "NASA"
        position: "астронавт"
        profileData: [
            ListElement  { value: "+1(800)-000-00-07"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Уапаконета"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "armstrong@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "5 августа 1930"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Александр Александрович Алёхин"
        position: "чемпион мира по шахматам"
        profileData: [
            ListElement  { value: "+7(800)-000-00-08"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Москва"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "alehin@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "19(31) октября 1892"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Нильс Бор"
        company: "Институт Нильса Бора"
        position: "профессор"
        profileData: [
            ListElement  { value: "+45(800)-000-00-09"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Копенгагин"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "bohr@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "7 октября 1885"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Альберт Эйнштейн"
        company: "Институт Фундаментальных Исследований"
        position: "профессор"
        profileData: [
            ListElement  { value: "+49(800)-000-00-10"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Ульм"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "einstein@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "14 марта 1879"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
    ListElement {
        name: "Деннис Ритчи"
        company: "Гарвардский университет"
        position: "профессор"
        profileData: [
            ListElement  { value: "+1(800)-000-00-11"; icon: "qrc:/Contacts/Phone.png"; fieldName: "моб. телефон"; }
            ,ListElement { value: "Бронксвил"; icon: "qrc:/Contacts/City.png"; fieldName: "город"; }
            ,ListElement { value: "ritchi@programmist.me"; icon: "qrc:/Contacts/Mail.png"; fieldName: "e-mail"; }
            ,ListElement { value: "8 октября 1941"; icon: "qrc:/Contacts/Birthday.png"; fieldName: "день рождения"; }
        ]
    }
}
