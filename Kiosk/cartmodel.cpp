#include "cartmodel.h"
#include <QDebug>
#include <QTcpSocket>

CartModel::CartModel(QObject* parent) : QAbstractListModel(parent) {}

int CartModel::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent);
    return cartList.size();
}

QVariant CartModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= cartList.size())
        return QVariant();

    const CartItem& item = cartList[index.row()];
    switch (role) {
        case MenuRole: return item.menuName;
        case QuantityRole: return item.quantity;
        case Option1Role: return item.options.value(0);
        case Option2Role: return item.options.value(1);
        case Option3Role: return item.options.value(2);
        default: return QVariant();
    }
}

// 속성 이름 정의
QHash<int, QByteArray> CartModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[MenuRole] = "menu";
    roles[QuantityRole] = "quantity";
    roles[Option1Role] = "option1";
    roles[Option2Role] = "option2";
    roles[Option3Role] = "option3";
    return roles;
}

void CartModel::addItem(const QString& menu, int quantity, const QVector<int>& options) {
    qDebug() << "addItem called:" << menu << quantity << options;
    beginInsertRows(QModelIndex(), cartList.size(), cartList.size());
    cartList.append({menu, quantity, options});
    endInsertRows();
}

void CartModel::updateQuantity(int index, int newQuantity) {
    if (index < 0 || index >= cartList.size()) return;
    cartList[index].quantity = newQuantity;
    emit dataChanged(this->index(index), this->index(index), {QuantityRole});
}

//void CartModel::clear() {
//    beginResetModel();
//    cartList.clear();
//    endResetModel();
//}

void CartModel::removeItem(int index) {
    if (index >= 0 && index < cartList.size()) {
        beginRemoveRows(QModelIndex(), index, index);
        cartList.removeAt(index);
        endRemoveRows();
    }
}

//QJsonArray CartModel::serializeToJson() const {
//    QJsonArray jsonArray;  // JSON 배열 객체 (전체 결과 저장)

//    for (const CartItem& item : cartList) {  // cartList에 대해 반복
//        QJsonObject obj;  // CartItem (하나의 구조체 항목)
//        obj["menuName"] = item.menuName;
//        obj["quantity"] = item.quantity;

//        QJsonArray optionsArray;    //option vector -> JSON 배열
//        for (int opt : item.options)
//            optionsArray.append(opt);

//        obj["options"] = optionsArray;
//        jsonArray.append(obj);
//    }

//    return jsonArray;
//}


void CartModel::sendAllItemsToServer() {
    QList<QPair<QString, QVector<int>>> orders;

    for (const CartItem& item : cartList) {
        orders.append(qMakePair(item.menuName, item.options));
    }

    TcpSender sender;
    sender.sendOrders(orders);
}




