//
// Created by 安達 彰典 on 2013/08/22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#include "BattleScene.h"
#include "SimpleAudioEngine.h"
#include "CookieSprite.h"

using namespace cocos2d;
using namespace CocosDenshion;
using namespace std;

CCScene *BattleScene::scene() {
    CCScene *scene = CCScene::create();
    BattleScene *layer = BattleScene::create();
    scene->addChild(layer);
    return scene;
}

bool BattleScene::init() {
    if (!CCLayer::init()) {
        return false;
    }

    initForVariables();

    showBackground();
    showCookies();

    return true;
}

//変数の初期化
void BattleScene::initForVariables() {
    srand((unsigned) time(NULL));
    CookieSprite *cs = CookieSprite::createWithCookieType(kCookiePlane);
    m_cookieSize = cs->getContentSize().height;
}

//背景表示
void BattleScene::showBackground() {
    CCSize winSize = CCDirector::sharedDirector()->getWinSize();

    //背景生成
    m_background = CCSprite::create(PNG_BACKGROUND);
    m_background->setPosition(ccp(winSize.width / 2, winSize.height / 2));
    addChild(m_background, kZOrderBackground, kTagBackground);
}

//位置取得
CCPoint BattleScene::getPosition(int posIndexX, int posIndexY) {
//    float offsetX = m_background->getContentSize().width * 0.168;
    float offsetX = m_background->getContentSize().width * 0.0;
    float offsetY = m_background->getContentSize().height * 0.0;
    return CCPoint((posIndexX + 0.5) * m_cookieSize + offsetX, (posIndexY + 0.5) * m_cookieSize + offsetY);
}

//タグの取得
int BattleScene::getTag(int posIndexX, int posIndexY) {
    return kTagBaseCookie + posIndexX * 100 + posIndexY;
}

//プレイヤー表示
void BattleScene::showCookies() {
    for (int x = 0; x < MAX_BLOCK_X; x++) {
        for (int y = 0; y < MAX_BLOCK_Y; y++) {
            kCookie cookieType = (kCookie)(rand() % 5);
            int tag = getTag(x,y);
            m_cookieTags[cookieType].push_back(tag);

            CookieSprite* cp = CookieSprite::createWithCookieType(cookieType);
            cp->setPosition(getPosition(x,y));
            m_background->addChild(cp,kZOrderCookie, tag);
        }
    }
}


