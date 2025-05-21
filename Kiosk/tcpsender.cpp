#include "tcpsender.h"
#include <QDebug>

TcpSender::TcpSender(QObject *parent)
    : QObject(parent)
{}

void TcpSender::sendOrders(const QList<QPair<QString, QVector<int>>> &orders)
{
    QStringList orderStrings;

    for (const auto &order : orders) {
        QString menu = order.first;
        QVector<int> options = order.second;

        QStringList tokens;
           tokens << menu;
           tokens << QString::number(1);  // 수량 고정

           for (int i = 0; i < options.size(); ++i) {
               tokens << QString::number(options[i]);
           }

           QString oneOrder = tokens.join("@");
           orderStrings << oneOrder;

//        QString optionString;
//        for (int i = 0; i < options.size(); ++i) {
//            optionString += QString::number(options[i]);
//            if (i != options.size() - 1)
//                optionString += "@";
//        }

//        QString oneOrder = QString("%1:%2:%3").arg(menu).arg(1).arg(optionString);
//        orderStrings << oneOrder;
    }

    QString finalData = orderStrings.join("@");
    QByteArray payload = finalData.toUtf8();

    socket.connectToHost("10.10.14.2", 12345);
    if (socket.waitForConnected(1000)) {
        socket.write(payload);
        socket.flush();
        socket.waitForBytesWritten(1000);
        socket.disconnectFromHost();
        qDebug() << "Raw string sent to server:" << finalData;
    } else {
        qWarning() << "Connection failed!";
    }
}

