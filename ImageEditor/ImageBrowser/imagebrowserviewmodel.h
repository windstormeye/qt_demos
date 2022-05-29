#ifndef IMAGEBROWSERVIEWMODEL_H
#define IMAGEBROWSERVIEWMODEL_H

#include <QObject>

class ImageBrowserViewModel : public QObject
{
    Q_OBJECT
public:
    explicit ImageBrowserViewModel(QObject *parent = nullptr);

signals:

};

#endif // IMAGEBROWSERVIEWMODEL_H
