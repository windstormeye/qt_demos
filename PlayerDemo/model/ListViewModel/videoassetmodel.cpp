#include "videoassetmodel.h"
#include "../../helper/videoinfofetcher.h"

#include <QFile>
#include <QDir>

#include <iostream>

VideoAssetModel::VideoAssetModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void VideoAssetModel::addVideos(const QString &urls)
{
    QList<QString> urlArr = QList<QString>();
    urlArr.append(urls);

    if (urls.contains(",")) {
        urlArr = urls.split(",");
    }

    auto rowCount = m_datas.count();

    beginInsertRows(QModelIndex(), rowCount, rowCount + urlArr.count() - 1);

    int coverImageCount = 0;

    foreach(QString url, urlArr) {
        QString urlFileName = fileName(url);

        VideoInfoFetcher::fetchFirstFrameWithVideoUrl(url, [=, &coverImageCount] (const QImage &coverImage) {
            QString coverDirPath = QDir::currentPath() + "/cover_image";
            QDir dir;
            if (!dir.exists(coverDirPath)) {
                dir.mkdir(coverDirPath);
            }
            QString coverImageFilePath = QDir::currentPath() + "/cover_image/" + urlFileName + ".jpg";
            coverImage.save(coverImageFilePath, "jpg", -1);

            // NOTE: 加上前缀 "file://" 可通过本地文件的方式加载，默认 "qrc://" 方式找图
            auto asset = QSharedPointer<VideoAsset>(new VideoAsset(urlFileName, url, "file://" + coverImageFilePath));
            m_datas.append(asset);

            coverImageCount += 1;
            if ((coverImageCount == urlArr.count() - 1) || urlArr.count() == 1) {
               storeAssets();
               endInsertRows();
            }
        });
    }
}

/// 通过 url 获取资源名
QString VideoAssetModel::fileName(const QString urlString) {
    QStringList strings = urlString.split("/");
    // NOTE: / 分割后取最后一段，再 . 分割后取最后一段
    return strings.last().split(".").first();
}

void VideoAssetModel::removeVideo(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    m_datas.removeAt(index);
    endRemoveRows();

    storeAssets();
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

QString VideoAssetModel::urlAt(int position)
{
    return m_datas.at(position)->url();
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
