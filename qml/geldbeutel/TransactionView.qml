import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import "database.js" as Database

Tab {
    id: tabTransactions
    title: qsTr("Transaktionen", "Transaktionen als Tab name")

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
                transactionDetailWindow.loadTransaction(transactions.get(tableTransactions.currentRow));
                transactionDetailWindow.transactions = transactions;
                transactionDetailWindow.show();
            }
        }
        Action {
            id: deleteTransactionAction
            onTriggered: {
                var transaction = transactions.get(tableTransactions.currentRow);
                console.log("deleting transaction id " + transaction.id);
                Database.deleteTransaction(transaction);
                transactions.remove(tableTransactions.currentRow);
            }
        }
        TransactionDetailWindow {
            id: transactionDetailWindow
            accounts: mainWindow.account_ref
        }
        ToolBar {
            id: toolbarMain
            Layout.fillHeight: false
            Layout.fillWidth: true
            Row {
                ToolButton {
                    action: newTransactionAction
                    width: newTransactionText.width + 30
                    Text {
                        id: newTransactionText
                        anchors.centerIn: parent
                        text: "Neu"
                    }
                }
                ToolButton {
                    action: editTransactionAction
                    width: editTransactionText.width + 30
                    Text {
                        id: editTransactionText
                        anchors.centerIn: parent
                        text: "Bearbeiten"
                    }
                }
                ToolButton {
                    action: deleteTransactionAction
                    width: deleteTransactionText.width + 30
                    Text {
                        id: deleteTransactionText
                        anchors.centerIn: parent
                        text: "Löschen"
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
                title: "Konto"
                role: "accountname"
                width: parent.width / 5
            }
            TableViewColumn {
                id: colValue
                title: "Betrag"
                role: "value"
                width: parent.width / 5
            }
        }
        Component.onCompleted: {
            Database.selectTransactions(transactions);
        }
    }
}
