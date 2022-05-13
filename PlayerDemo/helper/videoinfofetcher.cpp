#include "videoinfofetcher.h"

#include <QtMultimedia/QMediaPlayer>
#include <QtMultimedia/QVideoSink>
#include <QtMultimedia/QVideoFrame>
#include <QThread>

VideoInfoFetcher::VideoInfoFetcher()
{

}

bool VideoInfoFetcher::fetchFirstFrameWithVideoUrl(const QString &url, std::function<void (const QImage &)> callback)
{
    auto player = new QMediaPlayer();
    player->setSource(QUrl(url));
    auto sink = new QVideoSink;
    player->setVideoSink(sink);

    QObject::connect(sink, &QVideoSink::videoFrameChanged, player, [=] (const QVideoFrame &frame) {
        if (frame.isValid()) {
            player->stop();
            callback(frame.toImage());
            delete player;
        }
    }, Qt::QueuedConnection);

    player->play();
    return true;
}

