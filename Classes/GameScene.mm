//
// Created by 安達 彰典 on 2013/08/22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#include "GameScene.h"
#include "SimpleAudioEngine.h"
#include "PlayerSprite.h"


using namespace cocos2d;
using namespace CocosDenshion;
using namespace std;

CCScene *GameScene::scene() {
    CCScene *scene = CCScene::create();
    GameScene *layer = GameScene::create();
    scene->addChild(layer);
    return scene;
}

bool GameScene::init() {
    if (!CCLayer::init()) {
        return false;
    }

    initForVariables();

    showBackground();
    showPlayer();

    return true;
}

void GameScene::showBackground() {
    CCSize winSize = CCDirector::sharedDirector()->getWinSize();

    //背景生成
    m_background = CCSprite::create(PNG_BACKGROUND);
    m_background->setPosition(ccp(winSize.width / 2, winSize.height / 2));
    addChild(m_background, kZOrderBackground, kTagBackground);
}

//変数の初期化
void GameScene::initForVariables() {
    srand((unsigned) time(NULL));
    PlayerSprite *pPlayer = PlayerSprite::createWithPlayerType(kPlayerFront);
    m_playerSize = pPlayer->getContentSize().height;
}

//位置取得
CCPoint GameScene::getPosition(int posIndexX, int posIndexY) {
    float offsetX = m_background->getContentSize().width * 0.168;
    float offsetY = m_background->getContentSize().height * 0.029;
    return CCPoint((posIndexX + 0.5) * m_playerSize + offsetX, (posIndexY + 0.5) * m_playerSize + offsetY);
}

//タグの取得
int GameScene::getTag(int posIndexX, int posIndexY) {
    return kTagBasePlayer + posIndexX * 100 + posIndexY;
}

//プレイヤー表示
void GameScene::showPlayer() {
    kPlayer playerType = kPlayerFront;
    int x = 0;
    int y = 0;
    int tag = getTag(x, y);

    PlayerSprite *pPlayer = PlayerSprite::createWithPlayerType(playerType);
    pPlayer->setPosition(getPosition(x, y));
    m_background->addChild(pPlayer, kZOrderPlayer, tag);
}


