import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import "database.js" as Database

Tab {
    id: tabTransactions
    title: qsTr("Transactions", "Transactions as Tab name")

    GridLayout {
        anchors.fill: parent
        columns: 1
        rows: 2
        Action {
            id: newTransactionAction
            onTriggered: {
                transactionDetailWindow.transaction = null;
                transactionDetailWindow.transactions = transactions;
                transactionDetailWindow.show();
                console.log(mainWindow.account_ref.get(0));
            }
        }
        Action {
            id: editTransactionAction
            onTriggered: {
                transactionDetailWindow.transaction = transactions.get(tableTransactions.currentRow);
                transactionDetailWindow.transactions = transactions;
                transactionDetailWindow.show();
            }
        }
        TransactionDetailWindow {
            id: transactionDetailWindow
        }
        ToolBar {
            id: toolbarMain
            Layout.fillHeight: false
            Layout.fillWidth: true
            Row {
                ToolButton {
                    action: newTransactionAction
                    Text {
                        anchors.centerIn: parent
                        text: "New"
                    }
                }
                ToolButton {
                    action: editTransactionAction
                    Text {
                        anchors.centerIn: parent
                        text: "Edit"
                    }
                }
            }
        }
        TableView {
            id: tableTransactions
            model: transactions
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
                id: colAccount
                title: "Account"
                role: "accountname"
                width: parent.width / 5
            }
            TableViewColumn {
                id: colValue
                title: "Value"
                role: "value"
                width: parent.width / 5
            }
        }
        Component.onCompleted: {
            Database.selectTransactions(transactions);
        }
    }
}
