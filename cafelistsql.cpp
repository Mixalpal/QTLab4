#include "cafelistsql.h"
#include "QObject"

cafeListSQL::cafeListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{
    QSqlDatabase::removeDatabase("myConnection");

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");
    db.setHostName("localhost");
        db.setPort(5432);
        db.setUserName("postgres");
        db.setPassword("admin");
        db.setDatabaseName("cafes");

     _isConnectionOpen = true;

    if(!db.open())
        {
            qDebug() << db.lastError().text();
            _isConnectionOpen = false;
        }

    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS cafes (Id SERIAL PRIMARY KEY, Name Text, Address Text, KitchenType Text, Time Text)");
        QSqlQuery qry(m_schema, db);
        qry.exec();
        refresh();
}

QSqlQueryModel* cafeListSQL::getModel(){
    return this;
}

bool cafeListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}

QHash<int, QByteArray> cafeListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "nameOfCafe";
    roles[Qt::UserRole + 2] = "addressOfCafe";
    roles[Qt::UserRole + 3] = "kitchenTypeOfCafe";
    roles[Qt::UserRole + 4] = "timeOfCafe";
    roles[Qt::UserRole + 5] = "idOfCafe";

    return roles;
}

QVariant cafeListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* cafeListSQL::SQL_SELECT =
        "SELECT Name, Address, KitchenType, Time, Id "
        "FROM cafes";

void cafeListSQL::refresh()
{
    this->setQuery(cafeListSQL::SQL_SELECT,db);
}

void cafeListSQL::add(const QString& Name, const QString& Address, const QString& KitchenType, const QString& Time) {
    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO cafes (Name, Address, KitchenType, Time) VALUES ('%1', '%2', '%3', '%4')")
            .arg(Name)
            .arg(Address)
            .arg(KitchenType)
            .arg(Time);
    query.exec(strQuery);

    refresh();
}

void cafeListSQL::edit(const QString& Name, const QString& Address, const QString& KitchenType, const QString& Time, const int Id) {
    QSqlQuery query(db);
    QString strQuery= QString("UPDATE cafes SET Name = '%1', Address = '%2', KitchenType = '%3', Time = '%4' WHERE Id = %5")
            .arg(Name)
            .arg(Address)
            .arg(KitchenType)
            .arg(Time)
            .arg(Id);
    query.exec(strQuery);

    refresh();
}

void cafeListSQL::del(const int Id){
    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM cafes WHERE Id = %1")
            .arg(Id);
    query.exec(strQuery);

    refresh();
}

QString cafeListSQL::count(const QString& KitchenType)
{
    QSqlQuery query(db);
    QString strQuery= QString("SELECT COUNT(Id) FROM cafes WHERE KitchenType = '%1'")
            .arg(KitchenType);

    query.exec(strQuery);
    QString info;
    while (query.next())
    {
        info = query.value(0).toString();
        qDebug() << info;
    }

    return(info);
}
