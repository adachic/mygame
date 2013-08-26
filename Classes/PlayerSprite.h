//
// Created by 安達 彰典 on 2013/08/24.
//
// To change the template use AppCode | Preferences | File Templates.
//

#ifndef __PlayerSprite_H_
#define __PlayerSprite_H_

#include "cocos2d.h"
#include "Config.h"

class PlayerSprite : public cocos2d::CCSprite {
protected:
    const char *getPlayerImageFileName(kPlayer playerType);

public:
    CC_SYNTHESIZE_READONLY(kPlayer, m_playerType, PlayerType);

    PlayerSprite();

    virtual ~PlayerSprite();

    virtual bool initWithPlayerType(kPlayer playerType);

    static PlayerSprite *createWithPlayerType(kPlayer playerType);

};

#endif //__PlayerSprite_H_
