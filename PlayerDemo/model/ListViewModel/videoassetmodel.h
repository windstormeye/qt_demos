#ifndef VIDEOASSETMODEL_H
#define VIDEOASSETMODEL_H

#include <QAbstractListModel>
#include <QList>

#include "../VideoAsset/videoasset.h"

class VideoAssetModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit VideoAssetModel(QObject *parent = nullptr);

    Q_INVOKABLE void addVideos(const QString &urls);
    Q_INVOKABLE void removeVideo(int index);
    Q_INVOKABLE void loadAssets();
    Q_INVOKABLE QString urlAt(int position);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

private:
    QList<QSharedPointer<VideoAsset>> m_datas;
    QString fileName(const QString urlString);
    void storeAssets();
};

#endif // VIDEOASSETMODEL_H
