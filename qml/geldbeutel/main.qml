import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import "database.js" as Database

Item {
    width: 800
    height: 600

    property var database

    function init()
    {
        Database.openDatabase();
    }

    TabView {
        anchors.fill: parent
        Tab {
            id: tabAccounts
            title: qsTr("Accounts", "Accounts as Tab name")
            TableView {
                id: tableAccounts
                anchors.fill: parent
                model: 5
                TableViewColumn {
                    id: colName
                    title: "Name"
                    width: parent.width / 5
                }
            }
        }
        Tab {
            id: tabTransactions
            title: qsTr("Transactions", "Transactions as Tab name")
        }
    }

    Component.onCompleted: {
        init();
    }
}
