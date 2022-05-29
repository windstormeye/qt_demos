#ifndef IMAGEASSET_H
#define IMAGEASSET_H

#include <QObject>

class ImageAsset : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title CONSTANT)
    Q_PROPERTY(QString fileUrl READ fileUrl CONSTANT)

public:
    explicit ImageAsset(QObject *parent = nullptr);
    ImageAsset(const QString &title, const QString &fileUrl);

    const QString &title() const;

    const QString &fileUrl() const;

signals:

private:
    QString m_title;
    QString m_fileUrl;

};

#endif // IMAGEASSET_H
