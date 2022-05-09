#include "videoinfofetcher.h"

#include <QtMultimedia/QMediaPlayer>
#include <QtMultimedia/QVideoSink>
#include <QtMultimedia/QVideoFrame>
#include <QThread>

QMediaPlayer* sharedPlayer() {
    static auto g_player = new QMediaPlayer();
    return g_player;
}

VideoInfoFetcher::VideoInfoFetcher()
{

}

bool VideoInfoFetcher::fetchFirstFrameWithVideoUrl(const QString &url, std::function<void (const QImage &)> callback)
{
    sharedPlayer()->setSource(QUrl(url));
    auto sink = new QVideoSink;
    sharedPlayer()->setVideoSink(sink);

    QObject::connect(sink, &QVideoSink::videoFrameChanged, sharedPlayer(), [=] (const QVideoFrame &frame) {
        if (frame.isValid()) {
            sharedPlayer()->stop();
            callback(frame.toImage());
        }
    }, Qt::QueuedConnection);

    sharedPlayer()->play();
    return true;
}

