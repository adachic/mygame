//
// Created by 安達 彰典 on 2013/08/24.
//
// To change the template use AppCode | Preferences | File Templates.
//


#include "PlayerSprite.h"

PlayerSprite::PlayerSprite() {
}

PlayerSprite::~PlayerSprite() {

}

PlayerSprite *PlayerSprite::createWithPlayerType(kPlayer playerType) {
    PlayerSprite *pRet = new PlayerSprite();
    if (pRet && pRet->initWithPlayerType(playerType)){
        pRet->autorelease();
        return pRet;
    }else{
        CC_SAFE_DELETE(pRet);
        return NULL;
    }
}

bool PlayerSprite::initWithPlayerType(kPlayer playerType) {
    if(!cocos2d::CCSprite::initWithFile(getPlayerImageFileName(playerType))){
        return false;
    }
    m_playerType = playerType;
    return true;
}

const char *PlayerSprite::getPlayerImageFileName(kPlayer playerType) {
    switch(playerType){
        case kPlayerFront:
            return "player01_01.png";
        default:
            CCAssert(false, "invalid playerType");
            return "";
    }
}
