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
    title: "Konto"

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

    function loadAccount(a)
    {
        if (a === null)
        {
            updateAccountWindow.account = a;
            accountName.text = "Girokonto";
            accountType.currentIndex = 0;
        }
        else
        {
            updateAccountWindow.account = a;
            accountName.text = a.name;
            var index = 0;
            for (index = 0; index < typeModel.count; index++)
            {
                if (typeModel.get(index).name === a.type)
                {
                    console.log("index = " + index);
                    break;
                }
            }
            accountType.currentIndex = index;
        }
    }

    property var account
    property var accounts

    ListModel {
        id: typeModel
        ListElement {
            name: "giro"
            desc: "Giro"
        }
        ListElement {
            name: "credit"
            desc: "Kredit"
        }
    }

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
            text: "Art"
        }
        ComboBox {
            id: accountType
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            model: typeModel
            textRole: "desc"
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
                text: "Abbrechen"
                onClicked: {
                    close();
                }
            }
        }
    }
}
