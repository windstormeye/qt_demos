#include "localimageprovider.h"

LocalImageProvider::LocalImageProvider(ImageType type, Flags flags): QQuickImageProvider(type, flags)
{

}

LocalImageProvider::~LocalImageProvider()
{

}

QImage LocalImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug() << "id: " << id;
    qDebug() << "size: " << size->width() << ", " << size->height();
    qDebug() << "requestSize: " << requestedSize.width() << ", " << requestedSize.height();

    QString adjustFilePath;
    // TODO: win 上过了，需要看下 mac 上 file://
    QString prefix = "file:///";
    if (id.contains(prefix)) {
        adjustFilePath = id.mid(prefix.length(), id.length());
    }

    QImage targetImage(adjustFilePath);
    return targetImage;
}
