import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import "database.js" as Database

Tab {
    id: tabAccounts
    title: qsTr("Accounts", "Accounts as Tab name")
    GridLayout {
        anchors.fill: parent
        columns: 1
        rows: 2
        Action {
            id: newAccountAction
            onTriggered: {
                accountDetailWindow.account = null;
                accountDetailWindow.accounts = accounts;
                accountDetailWindow.show();
            }
        }
        Action {
            id: editAccountAction
            onTriggered: {
                accountDetailWindow.account = accounts.get(tableAccounts.currentRow);
                accountDetailWindow.accounts = accounts;
                accountDetailWindow.show();
            }
        }
        AccountDetailWindow {
            id: accountDetailWindow
        }
        ListModel {
            id: accounts
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
