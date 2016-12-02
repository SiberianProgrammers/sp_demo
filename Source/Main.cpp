#include <SpApplication.h>

int main(int argc, char *argv[])
{
    // TODO Обернуть в tsTr
    sp::SpApplication app(argc, argv, "Сибирские Программисты");

    QFontDatabase::addApplicationFont(":/OpenSans-Bold.ttf");
    QFontDatabase::addApplicationFont(":/OpenSans-Regular.ttf");
    //QFontDatabase::addApplicationFont(":/PTSerif.ttf");
    //QFontDatabase::addApplicationFont(":/PTSerif_i.ttf");
    //QFontDatabase::addApplicationFont(":/PTSerif_b.ttf");


    app.setFont(QFont("PT Serif"));

    return app.exec(QUrl("qrc:/Main.qml"));
}
