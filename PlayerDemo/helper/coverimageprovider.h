#ifndef COVERIMAGEPROVIDER_H
#define COVERIMAGEPROVIDER_H

#include <QQuickImageProvider>

QString g_image_provider_name = "cover_image";
QString g_image_name_prefix = "image://" + g_image_provider_name + "/";

class CoverImageProvider: public QQuickImageProvider
{
public:
    CoverImageProvider(): QQuickImageProvider(QQuickImageProvider::Pixmap) {}

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override {
        return QPixmap(id);
    }
};

#endif // COVERIMAGEPROVIDER_H
