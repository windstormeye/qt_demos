#include "imageasset.h"

ImageAsset::ImageAsset(QObject *parent)
    : QObject{parent}
{

}

ImageAsset::ImageAsset(const QString &title, const QString &fileUrl) : m_title(title),
    m_fileUrl(fileUrl)
{}

const QString &ImageAsset::title() const
{
    return m_title;
}

const QString &ImageAsset::fileUrl() const
{
    return m_fileUrl;
}
