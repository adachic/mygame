//
// Created by 安達 彰典 on 2013/08/22.
//
// To change the template use AppCode | Preferences | File Templates.
//

#ifndef __GameScene_H_
#define __GameScene_H_

#include "cocos2d.h"
#include "Config.h"

#define PNG_BACKGROUND "white_bg.png"
#define MAX_COOKIE_X 7
#define MAX_COOKIE_Y 7

class BattleScene : public cocos2d::CCLayer {
protected:
    enum kTag {
        kTagBaseCookie = 10000,
        kTagBackground = 1,
    };
    enum kZOrder {
        kZOrderBackground,
        kZOrderCookie,
        kZOrderPlayer,
    };
    cocos2d::CCSprite *m_background;
    void showBackground();

    float m_cookieSize;
    std::map<kCookie, std::list<int>> m_cookieTags;

    void initForVariables();

    void showCookies();

    cocos2d::CCPoint getPosition(int posIndexX, int posIndexY);

    int getTag(int posIndexX, int posIndexY);

    void getTouchCookieTag(cocos2d::CCPoint touchPoint, int &tag, kCookie &cookieType);
    std::list<int> getSameColorCookieTags(int baseTag, kCookie cookieType);
    void removeCookie(std::list<int> cookieTags, kCookie cookieType);
    bool hasSameColorCookie(std::list<int> cookieTagList, int searchCookieTag);

public:
    virtual bool init();

    static cocos2d::CCScene *scene();

    CREATE_FUNC(BattleScene);

    virtual bool ccTouchBegan(cocos2d::CCTouch* pTouch, cocos2d::CCEvent* pEvent);
    virtual void ccTouchMoved(cocos2d::CCTouch* pTouch, cocos2d::CCEvent* pEvent);
    virtual void ccTouchEnded(cocos2d::CCTouch* pTouch, cocos2d::CCEvent* pEvent);
};

#endif //__GameScene_H_
