#include "videoassetmodel.h"

#include <QFile>

VideoAssetModel::VideoAssetModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void VideoAssetModel::addVideo(const QString &url)
{
    auto rowCount = m_datas.count();
    beginInsertRows(QModelIndex(), rowCount, rowCount);
    // TODO: 完善构造函数
    auto asset = QSharedPointer<VideoAsset>(new VideoAsset());
    m_datas.append(asset);
    endInsertRows();

    storeAssets();
}

void VideoAssetModel::removeVideo(int index)
{

}

void VideoAssetModel::loadAssets()
{
    QFile file("playlist.dat");

    if (file.open(QIODevice::ReadOnly | QIODevice::ExistingOnly)) {
        QDataStream in(&file);
        int num;
        in >> num;
        beginInsertRows(QModelIndex(), 0, num - 1);
        for (int i = 0; i < num; i++) {
            auto asset = QSharedPointer<VideoAsset>(new VideoAsset);
            asset->read(in);
            m_datas.append(asset);
        }
        endInsertRows();
    }
}

void VideoAssetModel::storeAssets() {
    QFile file("playlist.dat");
    if (file.open(QIODevice::WriteOnly)) {
        QDataStream out(&file);
        int num = m_datas.count();
        out << num;
        for (int i = 0; i < num; i++) {
            m_datas[i]->write(out);
        }
    }
}

int VideoAssetModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_datas.count();
}

QVariant VideoAssetModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    return QVariant::fromValue(m_datas[index.row()].data());
}

QHash<int, QByteArray> VideoAssetModel::roleNames() const
{
    QHash<int, QByteArray> hash;
    hash[0] = "asset";
    return hash;
}
