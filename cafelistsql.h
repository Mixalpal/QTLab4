#ifndef CAFELISTSQL_H
#define CAFELISTSQL_H

#include <QtSql>

class cafeListSQL : public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* cafeModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    int cafeCount;

    explicit cafeListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void add(const QString& Name, const QString& Address, const QString& KitchenType, const QString& Time);  // макрос указывает, что к методу можно обратиться из QML
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& Name, const QString& Address, const QString& KitchenType, const QString& Time, const int index);
    Q_INVOKABLE QString count(const QString& KitchenType);

signals:

public slots:

private:
    const static char* SQL_SELECT;
    QStringList listOfTypes;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // CAFELISTSQL_H
