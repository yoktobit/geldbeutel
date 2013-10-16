#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/geldbeutel/main.qml"));
    viewer.showExpanded();
    viewer.setTitle("Geldbeutel");

    return app.exec();
}
