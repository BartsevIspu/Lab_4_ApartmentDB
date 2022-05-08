#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
//#include <studentlist.h>
#include <QQmlContext>
#include "apartmentlistsql.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;  // движок для QML

    QQmlContext *context = engine.rootContext();    // получить корневой контекст модели

    apartmentListSQL viewModel(&app); // модель для приложения
    context->setContextObject(&viewModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
