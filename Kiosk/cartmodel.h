#ifndef CARTMODEL_H
#define CARTMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include "tcpsender.h"


struct CartItem {
    QString menuName;
    int quantity;
    QVector<int> options;
};

class CartModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit CartModel(QObject* parent = nullptr);

    enum CartRoles {
        MenuRole = Qt::UserRole + 1,
        QuantityRole,
        Option1Role,
        Option2Role,
        //Option3Role
    };

    // const QList<CartItem>& getCartList() const;  // getter
    // Q_INVOKABLE QJsonArray serializeToJson() const; //json
    Q_INVOKABLE void sendAllItemsToServer();

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addItem(const QString& menu, int quantity, const QVector<int>& options);
    Q_INVOKABLE void updateQuantity(int index, int newQuantity);    
    Q_INVOKABLE void removeItem(int index);
    // Q_INVOKABLE void clear();

private:
    QList<CartItem> cartList;  // 메뉴 저장하는 구조체 배열
};

#endif // CARTMODEL_H
