//#include "usermanager.h"
//#include <QDebug>

//UserManager::UserManager(QObject *parent): QObject(parent)
//{
//    initDatabase();
//}


//void UserManager::initDatabase()
//{
//    db = QSqlDatabase::addDatabase("QMYSQL");
//    db.setHostName("localhost");
//    db.setDatabaseName("smart_pub");
//    db.setUserName("root");
//    db.setPassword("1234");

//    if(!db.open()) {
//        qDebug() <<"MariaDB 연결 실패:" << db.lastError().text();
//    }
//    else{
//        qDebug() << "MariaDB 연결 성공";
//    }
//}

//void UserManager::checkIdAndRegister(const QString &id, const QString &password, const QString &name, const QString &phone)
//{
//    if(!db.isOpen()) {
//        qDebug() << "DB가 열려 있지 않음";
//        return;
//    }

//    QSqlQuery query;
//    query.prepare("SELECT COUNT(*) FROM members WHERE id = ?");
//    query.addBindValue(id);

//    if (!query.exec() || !query.next()) {
//        qDebug() << "ID 중복 확인 실패:" << query.lastError().text();
//        return;
//    }

//    if (query.value(0).toInt() > 0) {
//        qDebug() << "중복된 ID입니다.";
//        return;
//    }

//    query.prepare("INSERT INTO members (id, password, name, phone) "
//                  "VALUES (?, ?, ?, ?)");
//    query.addBindValue(id);
//    query.addBindValue(password);
//    query.addBindValue(name);
//    query.addBindValue(phone);

//    if (!query.exec()) {
//        qDebug() << "회원가입 실패:" << query.lastError().text();
//        emit registerSuccess();
//    }
//    else {
//        qDebug() << "회원가입 성공!";
//        emit registerFailed(query.lastError().text());
//    }
//}
