#ifndef COLORFORMATTER_H
#define COLORFORMATTER_H

#include <QImage>

class ColorFormatter
{
public:
    // 通过类方法只能无关初始化调用，但反复构造和释放 QImage 会有一定损耗，看看能不能直接从“共享渲染”
    ColorFormatter();
    static QImage toGrey(QString imgUrl, float value);
};

#endif // COLORFORMATTER_H
