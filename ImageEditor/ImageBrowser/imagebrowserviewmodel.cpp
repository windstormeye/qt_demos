#include "imagebrowserviewmodel.h"
#include "../Models/ImageAsset/imageasset.h"
#include <QUrl>

ImageBrowserViewModel::ImageBrowserViewModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

void ImageBrowserViewModel::addImageAssetWithUrl(const QVariantList &urls)
{
    beginInsertRows(QModelIndex(), m_datas.count(), m_datas.count() + urls.count() - 1);

    foreach(QVariant url, urls) {
        QString urlString = url.toString();
        QString title = urlString.split("/").last();
        QSharedPointer<ImageAsset> asset = QSharedPointer<ImageAsset>(new ImageAsset(title, urlString));
        m_datas.append(asset);
    }

    endInsertRows();

    emit dataUpdated();
}

QVariant ImageBrowserViewModel::modelAt(int index)
{
    return QVariant::fromValue(m_datas.at(index).data());
}

int ImageBrowserViewModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }
    return m_datas.count();
}

QVariant ImageBrowserViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    return QVariant::fromValue(m_datas[index.row()].data());
}

QHash<int, QByteArray> ImageBrowserViewModel::roleNames() const
{
    QHash<int, QByteArray> hash;
    hash[0] = "asset";
    return hash;
}
