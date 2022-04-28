#ifndef VIDEOINFOFETCHER_H
#define VIDEOINFOFETCHER_H

#include <QString>
#include <QImage>

class VideoInfoFetcher
{
public:
    VideoInfoFetcher();

    bool fetchFirstFrameWithVideoUrl(const QString& url, std::function<void(const QImage&)> callback);
};

#endif // VIDEOINFOFETCHER_H
