#include <SpApplication.h>

int main(int argc, char *argv[])
{
    // TODO Обернуть в tsTr
    sp::SpApplication app(argc, argv, "Сибирские Программисты");

    QFontDatabase::addApplicationFont(":/Century-Gothic-Bold.TTF");
    QFontDatabase::addApplicationFont(":/Century-Gothic-BoldIt.TTF");
    QFontDatabase::addApplicationFont(":/Century-Gothic-It.TTF");
    QFontDatabase::addApplicationFont(":/Century-Gothic.TTF");

    app.setFont(QFont("Century Gothic"));

    return app.exec();
}
