#include "cartmodel.h"

CartModel::CartModel(QObject* parent) : QObject(parent) {}

void CartModel::increase(const QString& menu, int index) {
    auto& list = cartData[menu];
    if (list.size() <= index) list.resize(index + 1);
    list[index]++;
    emit dataChanged();
}

void CartModel::decrease(const QString& menu, int index) {
    auto& list = cartData[menu];
    if (list.size() <= index) return;
    if (list[index] > 0) list[index]--;
    emit dataChanged();
}

int CartModel::getQuantity(const QString& menu, int index) const {
    auto it = cartData.find(menu);
    if (it == cartData.end() || it->size() <= index) return 0;
    return it->at(index);
}

QVariantList CartModel::getItems() const {
    QVariantList list;
    for (auto it = cartData.constBegin(); it != cartData.constEnd(); ++it) {
        QVariantMap item;
        item["menu"] = it.key();
        item["quantities"] = QVariant::fromValue(it.value());
        list.append(item);
    }
    return list;
}
