#include <AppContrastRectangle/version.hpp>

#include <iostream>
#include <filesystem>
#include <stdexcept>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include <QQuickWindow>
#include <QObject>
#include <QDebug>
#include <QFile>

namespace AppContrastRectangle
{

namespace fs = std::filesystem;

//
// main()
//

int main(int argc, char** argv)
{
    QGuiApplication qtApp( argc, argv );
    QQmlApplicationEngine engine;

    const QUrl url(
        QStringLiteral( "qrc:/AppContrastRectangle/qml/MyMainWindow.qml" ) );

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &qtApp,
        [ url ]( QObject * obj, const QUrl & objUrl ) {
            if( !obj && url == objUrl ) QCoreApplication::exit( -1 );
        },
        Qt::QueuedConnection );
    engine.load( url );

    const auto retValue = qtApp.exec();
    if( 0 != retValue )
    {
        qWarning() << "Application finished with error...";
    }

    return 0;
}

}  // namespace AppContrastRectangle
