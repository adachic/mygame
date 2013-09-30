//
// Created by 安達 彰典 on 2013/09/29.
//
// To change the template use AppCode | Preferences | File Templates.
//

#ifndef __CookieSprite_H_
#define __CookieSprite_H_

#include "cocos2d.h"
#include "Config.h"

class CookieSprite : public cocos2d::CCSprite {
protected:
    const char *getCookieImageFileName(kCookie cookieType);

public:
    CC_SYNTHESIZE_READONLY(kCookie, m_cookieType, CookieType);

    CookieSprite();

    virtual ~CookieSprite();

    virtual bool initWithCookieType(kCookie cookieType);

    static CookieSprite *createWithCookieType(kCookie cookieType);
};

#endif //__CookieSprite_H_