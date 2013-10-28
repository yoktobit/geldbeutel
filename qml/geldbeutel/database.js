.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var database;

function openDatabase() {
    database = Sql.LocalStorage.openDatabaseSync(
        "GeldBeutel",
        "1.0",
        "GeldBeutel Local Data",
        100
    );

    database.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT"
                          + ", name TEXT"
                          + ", type TEXT"
                          + ", insertdate DATETIME"
                          + ", updatedate DATETIME"
                          + ", fixvalue NUMBER"
                          + ", fixdate DATETIME)");
            tx.executeSql("CREATE TABLE IF NOT EXISTS transfer(id INTEGER PRIMARY KEY AUTOINCREMENT"
                          + ", name TEXT"
                          + ", account INTEGER"
                          + ", value NUMBER"
                          + ", insertdate DATETIME"
                          + ", updatedate DATETIME)");
            //tx.executeSql("DELETE FROM account");
        }
    );
}

function insertAccount(account)
{
    var insert = "INSERT INTO account(name, type, insertdate, updatedate, fixvalue, fixdate) VALUES(?, ?, ?, ?, ?, ?)";
    var data = [
        account.name,
        account.type,
        new Date(),
        new Date(),
        0,
        new Date()
    ];
    database.transaction(
        function(tx) {
            tx.executeSql(insert, data);
        }
    );
}

function updateAccount(account)
{
    var update = "UPDATE account SET name = ?, type = ?, updatedate = ? WHERE id = ?";
    var data = [
        account.name,
        account.type,
        new Date(),
        account.id
    ];
    database.transaction(
        function(tx) {
            tx.executeSql(update, data);
        }
    );
}

function selectAccounts(accounts)
{
    if (!database)
    {
        openDatabase();
    }
    database.transaction(
        function(tx) {
            // Show all accounts
            var rs = tx.executeSql('SELECT id, name, type FROM account');
            var r = "";
            accounts.clear();
            for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i));
                console.log(rs.rows.item(i).name);
                accounts.append({"id": rs.rows.item(i).id, "name": rs.rows.item(i).name, "type": rs.rows.item(i).type});
            }
        }
    );
}

function insertTransaction(transaction)
{
    var insert = "INSERT INTO transfer(name, account, value, insertdate, updatedate) VALUES(?, ?, ?, ?, ?)";
    var data = [
        transaction.name,
        transaction.account,
        transaction.value,
        new Date(),
        new Date()
    ];
    database.transaction(
        function(tx) {
            tx.executeSql(insert, data);
        }
    );
}

function updateTransaction(transaction)
{
    var insert = "UPDATE transfer SET name = ?, account = ?, value = ?, updatedate = ? WHERE id = ?";
    var data = [
        transaction.name,
        transaction.account,
        transaction.value,
        new Date(),
        transaction.id
    ];
    database.transaction(
        function(tx) {
            tx.executeSql(insert, data);
        }
    );
}

function selectTransactions(transactions)
{
    if (!database)
    {
        openDatabase();
    }
    database.transaction(
        function(tx) {
            // Show all accounts
            var rs = tx.executeSql('SELECT transfer.id id, transfer.name name, transfer.account account, transfer.value value, account.name accountname FROM transfer, account where account.id = transfer.account');
            var r = "";
            transactions.clear();
            for(var i = 0; i < rs.rows.length; i++) {
                console.log(rs.rows.item(i));
                console.log(rs.rows.item(i).name);
                transactions.append({"id": rs.rows.item(i).id
                                    , "name": rs.rows.item(i).name
                                    , "account": rs.rows.item(i).account
                                    , "accountname": rs.rows.item(i).accountname
                                    , "value": rs.rows.item(i).value});
            }
        }
    );
}
