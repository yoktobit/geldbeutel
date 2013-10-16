import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import "database.js" as Database

Window {
    id: updateAccountWindow
    modality: Qt.ApplicationModal
    width: gridLayout.width
    height: gridLayout.height
    title: "Account"

    function save()
    {
        if (!account)
        {
            account = {name: accountName.text, type: accountType.currentText};
            Database.insertAccount(account);
            accounts.append(account);
        }
        else
        {
            account.name = accountName.text;
            account.type = accountType.currentText;
            Database.updateAccount(account);
        }
    }

    property var account
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
            id: accountName
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            text: "Girokonto"
        }
        Text {
            Layout.row: 1
            Layout.column: 0
            width: parent.width
            text: "Type"
        }
        ComboBox {
            id: accountType
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            model: ["giro", "credit"]
        }

        Row {
            Layout.row: 2
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
