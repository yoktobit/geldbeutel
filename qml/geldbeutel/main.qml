import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.LocalStorage 2.0
import "database.js" as Database

Item {
    width: 800
    height: 600

    property var database

    ListModel {
        id: accounts
    }

    function init()
    {
        Database.openDatabase();
        Database.selectAccounts();
    }

    TabView {
        anchors.fill: parent
        Tab {
            id: tabAccounts
            title: qsTr("Accounts", "Accounts as Tab name")
            TableView {
                id: tableAccounts
                anchors.fill: parent
                model: accounts
                TableViewColumn {
                    id: colName
                    title: "Name"
                    role: "name"
                    width: parent.width / 5
                }
                TableViewColumn {
                    id: colType
                    title: "Type"
                    role: "type"
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
