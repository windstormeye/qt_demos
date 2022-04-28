#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "model/ListViewModel/videoassetmodel.h"
#include "helper/coverimageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<VideoAssetModel>("com.pjhubs.asset", 1, 0, "VideoAssetModel");
    engine.addImageProvider(g_image_provider_name.toLatin1(), new CoverImageProvider);

    const QUrl url("qrc:/qml/qml/main.qml");
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
