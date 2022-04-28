#ifndef VIDEOASSET_H
#define VIDEOASSET_H

#include <QObject>

class VideoAsset : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString url READ url CONSTANT)
    Q_PROPERTY(QString coverImage READ coverImage CONSTANT)

public:
    explicit VideoAsset(QObject *parent = nullptr);
    VideoAsset(const QString &name, const QString &url, const QString &coverImage);

    const QString &name() const;
    const QString &url() const;
    const QString &coverImage() const;

    const QDataStream &read(QDataStream &in);
    const QDataStream &write(QDataStream &out);

signals:

private:
    QString m_name;
    QString m_url;
    QString m_coverImage;
};

#endif // VIDEOASSET_H
