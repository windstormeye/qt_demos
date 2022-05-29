#ifndef IMAGEBROWSERVIEWMODEL_H
#define IMAGEBROWSERVIEWMODEL_H

#include <QAbstractListModel>
#include <QList>

#include "../Models/ImageAsset/imageasset.h"

class ImageBrowserViewModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ImageBrowserViewModel(QObject *QAbstractListModel = nullptr);

    // 添加文件 urls
    Q_INVOKABLE void addImageAssetWithUrl(const QVariantList &urls);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

signals:
    void dataUpdated();
private:
    QList<QSharedPointer<ImageAsset>> m_datas;
};

#endif // IMAGEBROWSERVIEWMODEL_H
