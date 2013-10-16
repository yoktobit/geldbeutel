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

    TabView {
        anchors.fill: parent
        AccountView {
            id: accountView
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
