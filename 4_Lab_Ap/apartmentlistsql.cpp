#include "apartmentlistsql.h"
#include "QObject"

apartmentListSQL::apartmentListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{
    QSqlDatabase::removeDatabase("myConnection");

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");
    db.setHostName("localhost");
        db.setPort(5432);
        db.setUserName("postgres");
        db.setPassword("wordpass");
        db.setDatabaseName("apartments");

     _isConnectionOpen = true;

    if(!db.open())
        {
            qDebug() << db.lastError().text();
            _isConnectionOpen = false;
        }

    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS Apartments (Id SERIAL PRIMARY KEY, District text, Floor text, Room text, Material text, Area text);" );
    QSqlQuery qry(m_schema, db);
        qry.exec();
        refresh();
}

QSqlQueryModel* apartmentListSQL::getModel(){
    return this;
}
bool apartmentListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> apartmentListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Qt::UserRole + 2] = "districtOfAp";
    roles[Qt::UserRole + 3] = "roomOfAp";
    roles[Qt::UserRole + 4] = "floorOfAp";
    roles[Qt::UserRole + 5] = "materialOfAp";
    roles[Qt::UserRole + 6] = "areaOfAp";
    roles[Qt::UserRole + 1] = "Id_apartment";

    /*roles[district] = "districtOfAp";
    roles[room] = "roomOfAp";
    roles[floor] = "floorOfAp";
    roles[material] = "materialOfAp";
    roles[area] = "areaOfAp";*/

    return roles;
}

QVariant apartmentListSQL::data(const QModelIndex &index, int role) const
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

const char* apartmentListSQL::SQL_SELECT =
        "SELECT *"
        "FROM apartments";

void apartmentListSQL::refresh()
{
    this->setQuery(apartmentListSQL::SQL_SELECT,db);
    qDebug() << db.lastError().text();
}

void apartmentListSQL::add(const QString& districtAp, const QString& floorAp, const QString& roomAp, const QString& materialAp, const QString& areaAp){

    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO apartments (District,Floor,Room,Material,Area) VALUES ('%1', '%2', '%3', '%4', '%5')")
            .arg(districtAp)
            .arg(floorAp)
            .arg(roomAp)
            .arg(materialAp)
            .arg(areaAp);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void apartmentListSQL::edit(const QString& districtAp, const QString& floorAp, const QString& roomAp, const QString& materialAp, const QString& areaAp, const int Id_apartment){

    QSqlQuery query(db);
    QString strQuery= QString("UPDATE apartments SET District = '%1',Floor = '%2',Room = '%3',Material = '%4', Area = '%5'  WHERE Id = %6")
            .arg(districtAp)
            .arg(floorAp)
            .arg(roomAp)
            .arg(materialAp)
            .arg(areaAp)
            .arg(Id_apartment);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void apartmentListSQL::del(const int Id_apartment){

    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM apartments WHERE Id = %1")
            .arg(Id_apartment);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}
