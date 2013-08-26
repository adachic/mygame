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

class GameScene : public cocos2d::CCLayer {
protected:
    enum kTag {
        kTagBasePlayer = 10000,
        kTagBackground = 1,
    };
    enum kZOrder {
        kZOrderBackground,
        kZOrderPlayer,
    };
    cocos2d::CCSprite *m_background;
    void showBackground();

    float m_playerSize;
    std::map<kPlayer, std::list<int>> m_blockTags;

    void initForVariables();

    void showPlayer();

    cocos2d::CCPoint getPosition(int posIndexX, int posIndexY);

    int getTag(int posIndexX, int posIndexY);

public:
    virtual bool init();

    static cocos2d::CCScene *scene();

    CREATE_FUNC(GameScene);
};

#endif //__GameScene_H_
