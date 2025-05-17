#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>
#include <QtSql>

class UserManager : public QObject
{
    Q_OBJECT
public:
    explicit UserManager(QObject *parent = nullptr);

    Q_INVOKABLE void checkIdAndRegister(const QString &id,
                                        const QString &pw,
                                        const QString &name,
                                        const QString &phone);

private:
    QSqlDatabase db;
};

#endif // USERMANAGER_H
