import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.0
import "database.js" as Database

Item {
    id: mainWindow
    width: 800
    height: 600

    function init()
    {
        Database.openDatabase();
    }

    property alias account_ref: accounts

    ListModel {
        id: accounts
    }
    ListModel {
        id: transactions
    }

    TabView {
        anchors.fill: parent
        AccountView {
            id: accountView
        }
        TransactionView {
            id: transactionView
        }
    }

    Component.onCompleted: {
        init();
    }
}
