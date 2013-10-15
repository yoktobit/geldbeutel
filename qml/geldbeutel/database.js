.import QtQuick.LocalStorage 2.0 as Sql

function openDatabase() {
    database = Sql.LocalStorage.openDatabaseSync(
        "GeldBeutel",
        "1.0",
        "GeldBeutel Local Data",
        100
    );
    var insert = "INSERT INTO account(name, type, insertdate, updatedate, fixvalue, fixdate) VALUES(?, ?, ?, ?, ?, ?)";
    var data = [
        testkonto,
        "giro",
        new Date(),
        new Date(),
        0,
        new Date()
    ];

    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT
                         , name TEXT
                         , type TEXT
                         , insertdate DATETIME
                         , updatedate DATETIME
                         , fixvalue NUMBER
                         , fixdate DATETIME)');
            tx.executeSql(dataStr, data);
        }
    );
}

function selectData()
{

}
