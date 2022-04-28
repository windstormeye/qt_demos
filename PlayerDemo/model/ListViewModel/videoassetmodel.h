#ifndef VIDEOASSETMODEL_H
#define VIDEOASSETMODEL_H

#include <QAbstractListModel>
#include <QList>

#include "../VideoAsset/videoasset.h"

//#include "videoassetmodel.h"
// TODO: 打开这个头文件后

class VideoAssetModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit VideoAssetModel(QObject *parent = nullptr);

    Q_INVOKABLE void addVideo(const QString &url);
    Q_INVOKABLE void removeVideo(int index);
    Q_INVOKABLE void loadAssets();
    void storeAssets();

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

private:
    QList<QSharedPointer<VideoAsset>> m_datas;
};

#endif // VIDEOASSETMODEL_H
