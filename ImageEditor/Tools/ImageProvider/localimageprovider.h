#ifndef LOCALIMAGEPROVIDER_H
#define LOCALIMAGEPROVIDER_H

#include <QQuickImageProvider>

class LocalImageProvider: public QQuickImageProvider
{
public:
    LocalImageProvider(ImageType type, Flags flags = Flags());

    ~LocalImageProvider();

    QImage requestImage(const QString &id, QSize *size, const QSize& requestedSize);
};

#endif // LOCALIMAGEPROVIDER_H
