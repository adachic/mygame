//
// Created by 安達 彰典 on 2013/09/29.
//
// To change the template use AppCode | Preferences | File Templates.
//


#include "CookieSprite.h"

CookieSprite::CookieSprite() {
}

CookieSprite::~CookieSprite() {

}

CookieSprite *CookieSprite::createWithCookieType(kCookie cookieType) {
    CookieSprite *pRet = new CookieSprite();
    if (pRet && pRet->initWithCookieType(cookieType)){
        pRet->autorelease();
        return pRet;
    }else{
        CC_SAFE_DELETE(pRet);
        return NULL;
    }
}

bool CookieSprite::initWithCookieType(kCookie cookieType) {
    if(!cocos2d::CCSprite::initWithFile(getCookieImageFileName(cookieType))){
        return false;
    }
    m_cookieType = cookieType;
    return true;
}

const char *CookieSprite::getCookieImageFileName(kCookie cookieType) {
    switch(cookieType){
        case kCookiePlane:
            return "Plane.png";
        case kCookieBlue:
            return "Blue.png";
        case kCookieYellow:
            return "Yellow.png";
        case kCookieRed:
            return "Red.png";
        case kCookieGreen:
            return "Green.png";
        default:
            CCAssert(false, "invalid cookieType");
            return "";
    }
}
