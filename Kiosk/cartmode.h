#ifndef CARTMODE_H
#define CARTMODE_H

#pragma once
#include <QObject>
#include <QVariantList>
#include <QMap>

class CartModel : public QObject {
    Q_OBJECT
public:
    explicit CartModel(QObject* parent = nullptr);

    Q_INVOKABLE void increase(const QString& menu, int optionIndex);
    Q_INVOKABLE void decrease(const QString& menu, int optionIndex);
    Q_INVOKABLE int getQuantity(const QString& menu, int optionIndex) const;
    Q_INVOKABLE QVariantList getItems() const;

signals:
    void dataChanged();

private:
    QMap<QString, QVector<int>> cartData; // 메뉴 이름 -> 옵션 수량 리스트
};


#endif // CARTMODE_H
