#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "cartmodel.h"
#include "tcpsender.h"


int main(int argc, char *argv[])
{    
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    CartModel* cartModel = new CartModel();    
    engine.rootContext()->setContextProperty("CartModel", cartModel); // 글로벌 객체 등록

    qmlRegisterType<TcpSender>("TcpComm", 1, 0, "TcpSender"); //

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);    

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
