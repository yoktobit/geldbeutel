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
        "testkonto",
        "giro",
        new Date(),
        new Date(),
        0,
        new Date()
    ];

    database.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT"
                          + ", name TEXT"
                          + ", type TEXT"
                          + ", insertdate DATETIME"
                          + ", updatedate DATETIME"
                          + ", fixvalue NUMBER"
                          + ", fixdate DATETIME)");
            tx.executeSql(insert, data);
        }
    );
}

function selectAccounts()
{
    database.transaction(
        function(tx) {
            // Show all accounts
            var rs = tx.executeSql('SELECT name, type FROM account');
            var r = "";
            for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i));
                console.log(rs.rows.item(i).name);
                accounts.append({"name": rs.rows.item(i).name, "type": rs.rows.item(i).type});
            }
        }

    );
}
