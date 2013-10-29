import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import "database.js" as Database

Window {
    id: updateTransactionWindow
    modality: Qt.ApplicationModal
    width: gridLayout.width
    height: gridLayout.height
    title: "Transaction"

    function save()
    {
        if (!transaction)
        {
            transaction = {name: transactionName.text
                , account: transactionAccount.model.get(transactionAccount.currentIndex).id
                , accountname: transactionAccount.model.get(transactionAccount.currentIndex).name
                , value: transactionValue.text * 1};
            console.log("account: " + transaction.account);
            Database.insertTransaction(transaction);
            transactions.append(transaction);
        }
        else
        {
            transaction.name = transactionName.text;
            transaction.account = transactionAccount.model.get(transactionAccount.currentIndex).id;
            transaction.value = transactionValue.text * 1;
            console.log("account: " + transaction.account);
            Database.updateTransaction(transaction);
        }
    }

    property var transaction
    property var transactions
    property var accounts

    GridLayout {
        id: gridLayout
        anchors.centerIn: parent
        columns: 2
        rows: 10
        Text {
            Layout.row: 0
            Layout.column: 0
            width: parent.width
            text: "Name"
        }
        TextField {
            id: transactionName
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            text: "Geldautomat"
        }
        Text {
            Layout.row: 1
            Layout.column: 0
            width: parent.width
            text: "Account"
        }
        ComboBox {
            id: transactionAccount
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            model: mainWindow.account_ref
            textRole: "name"
        }
        Text {
            Layout.row: 2
            Layout.column: 0
            text: "value"
        }
        TextField {
            id: transactionValue
            Layout.row: 2
            Layout.column: 1
            Layout.fillWidth: true
            text: "1.00"
            validator: DoubleValidator { }
        }

        Row {
            Layout.row: 3
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.alignment: Layout.Center
            Button {
                text: "OK"
                onClicked: {
                    save();
                    close();
                }
            }
            Button {
                text: "Abort"
                onClicked: {
                    close();
                }
            }
        }
    }
}
