#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
//#include "usermanager.h"
#include "cartmodel.h"

static QObject* cartModel_singletontype_provider(QQmlEngine*, QJSEngine*) {
    return new CartModel();
}


int main(int argc, char *argv[])
{
    //qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    CartModel* cartModel = new CartModel();

    //engine.rootContext()->setContextProperty("CartModel", &cartModel);

    engine.rootContext()->setContextProperty("CartModel", cartModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);    

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
