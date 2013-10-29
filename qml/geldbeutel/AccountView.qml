import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import "database.js" as Database

Tab {
    id: tabAccounts
    title: qsTr("Accounts", "Accounts as Tab name")
    GridLayout {
        id: tabAccountGrid
        anchors.fill: parent
        columns: 1
        rows: 2
        Action {
            id: newAccountAction
            onTriggered: {
                accountDetailWindow.loadAccount(null);
                accountDetailWindow.accounts = accounts;
                accountDetailWindow.show();
            }
        }
        Action {
            id: editAccountAction
            onTriggered: {
                accountDetailWindow.loadAccount(accounts.get(tableAccounts.currentRow));
                accountDetailWindow.accounts = accounts;
                accountDetailWindow.show();
            }
        }
        Action {
            id: deleteAccountAction
            onTriggered: {
                var account = accounts.get(tableAccounts.currentRow);
                Database.deleteAccount(account);
            }
        }
        AccountDetailWindow {
            id: accountDetailWindow
        }
        ToolBar {
            id: toolbarMain
            Layout.fillHeight: false
            Layout.fillWidth: true
            Row {
                ToolButton {
                    action: newAccountAction
                    Text {
                        anchors.centerIn: parent
                        text: "New"
                    }
                }
                ToolButton {
                    action: editAccountAction
                    Text {
                        anchors.centerIn: parent
                        text: "Edit"
                    }
                }
                ToolButton {
                    action: deleteAccountAction
                    Text {
                        anchors.centerIn: parent
                        text: "Delete"
                    }
                }
            }
        }
        TableView {
            id: tableAccounts
            model: accounts
            width: parent.width
            Layout.fillHeight: true
            Layout.fillWidth: true
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
        Component.onCompleted: {
            Database.selectAccounts(accounts);
        }
    }
}
