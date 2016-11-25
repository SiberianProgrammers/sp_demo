#include <SpApplication.h>

int main(int argc, char *argv[])
{
    // TODO Обернуть в tsTr
    sp::SpApplication app(argc, argv, "Сибирские Программисты");

    QFontDatabase::addApplicationFont(":/OpenSans-Bold.ttf");
    QFontDatabase::addApplicationFont(":/OpenSans-Regular.ttf");

    app.setFont(QFont("Open Sans"));

    return app.exec(QUrl("qrc:/Main.qml"));
}
