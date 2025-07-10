#include "iostream"
#include <qqml.h>
#include <qguiapplication.h>
#include <qqmlapplicationengine.h>
#include <qqmlcontext.h>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    if (argc == 2)
    {
        engine.rootContext()->setContextProperty("d_url", QUrl(QString::fromLocal8Bit(argv[1])));
    }
    else
    {
        engine.rootContext()->setContextProperty("d_url", QUrl("qrc:/qrc/BlankView.qml"));
    }
    engine.load(QUrl("qrc:/qrc/MainView.qml"));

    return app.exec();
}
