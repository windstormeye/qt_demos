#include "videoasset.h"

VideoAsset::VideoAsset(QObject *parent)
    : QObject{parent}
{

}

const QString &VideoAsset::name() const
{
    return m_name;
}

const QString &VideoAsset::url() const
{
    return m_url;
}

const QString &VideoAsset::coverImage() const
{
    return m_coverImage;
}

const QDataStream &VideoAsset::read(QDataStream &in)
{
    in >> m_name >> m_url >> m_coverImage;
    return in;
}

const QDataStream &VideoAsset::write(QDataStream &out)
{
    out << m_name << m_url << m_coverImage;
    return out;
}

VideoAsset::VideoAsset(const QString &name, const QString &url, const QString &coverImage) : m_name(name),
    m_url(url),
    m_coverImage(coverImage)
{}
