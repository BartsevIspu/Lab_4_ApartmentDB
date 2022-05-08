#ifndef APARTMENTLISTSQL_H
#define APARTMENTLISTSQL_H

#include <QtSql>

class apartmentListSQL: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* apartmentModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    explicit apartmentListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;



    Q_INVOKABLE void add(const QString& districtAp, const QString& roomAp, const QString& floorAp, const QString& materialAp, const QString& areaAp);  // макрос указывает, что к методу можно обратиться из QML
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& districtAp, const QString& roomAp, const QString& floorAp, const QString& materialAp, const QString& areaAp, const int index);
signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // APARTMENTLISTSQL_H
