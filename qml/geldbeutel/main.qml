import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.0
import "database.js" as Database

Item {
    width: 800
    height: 600

    property var database

    function init()
    {
        Database.openDatabase();
        Database.selectAccounts();
    }

    ListModel {
        id: accounts
    }

    Action {
        id: printSmth
        onTriggered: {
            updateAccountWindow.show();
        }
    }

    Window {
        id: updateAccountWindow
        width: 100
        height: 100
        modality: Qt.ApplicationModal
    }

    TabView {
        anchors.fill: parent
        Tab {
            id: tabAccounts
            title: qsTr("Accounts", "Accounts as Tab name")
            GridLayout {
                anchors.fill: parent
                columns: 1
                rows: 2
                ToolBar {
                    id: toolbarMain
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    ToolButton {
                        action: printSmth
                        Text {
                            anchors.centerIn: parent
                            text: "Test"
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
