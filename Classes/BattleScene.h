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
#define MAX_BLOCK_X 13
#define MAX_BLOCK_Y 13

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

public:
    virtual bool init();

    static cocos2d::CCScene *scene();

    CREATE_FUNC(BattleScene);
};

#endif //__GameScene_H_
