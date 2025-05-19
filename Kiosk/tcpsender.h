#ifndef TCPSENDER_H
#define TCPSENDER_H


#include <QObject>
#include <QTcpSocket>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

class TcpSender : public QObject
{
    Q_OBJECT
public:
    explicit TcpSender(QObject *parent = nullptr);

    Q_INVOKABLE void sendOrders(const QList<QPair<QString, QVector<int>>> &orders);

private:
    QTcpSocket socket;
};

#endif // TCPSENDER_H
