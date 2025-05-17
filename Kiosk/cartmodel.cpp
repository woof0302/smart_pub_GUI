#include "cartmodel.h"
#include <QDebug>

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

void CartModel::clear() {
    beginResetModel();
    cartList.clear();
    endResetModel();
}

void CartModel::removeItem(int index) {
    if (index >= 0 && index < cartList.size()) {
        beginRemoveRows(QModelIndex(), index, index);
        cartList.removeAt(index);
        endRemoveRows();
    }
}



