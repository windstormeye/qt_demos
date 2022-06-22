#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "./ImageBrowser/imagebrowserviewmodel.h"
#include "./Models/ImageAsset/imageasset.h"
#include "./Tools/ImageProvider/localimageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<ImageBrowserViewModel>("com.pjhubs.image_editor", 1, 0, "ImageBrowserViewModel");
    qmlRegisterType<ImageAsset>("com.pjhubs.image_editor", 1, 0, "ImageAsset");

    LocalImageProvider *localImageProvider = new LocalImageProvider(QQmlImageProviderBase::Image);
    engine.addImageProvider("localImageProvider", localImageProvider);

    const QUrl url(u"qrc:/ImageEditor/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QCoreApplication::setOrganizationName("com.pjhubs.image_editor");

    return app.exec();
}
