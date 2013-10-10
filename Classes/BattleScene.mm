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

    setTouchEnabled(true);
    setTouchMode(kCCTouchesOneByOne);

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

//クッキー表示
void BattleScene::showCookies() {
    for (int x = 0; x < MAX_COOKIE_X; x++) {
        for (int y = 0; y < MAX_COOKIE_Y; y++) {
            kCookie cookieType = (kCookie) (rand() % 5);
            int tag = getTag(x, y);
            m_cookieTags[cookieType].push_back(tag);

            CookieSprite *cp = CookieSprite::createWithCookieType(cookieType);
            cp->setPosition(getPosition(x, y));
            m_background->addChild(cp, kZOrderCookie, tag);
        }
    }
}

//タッチされたクッキーのタグとタイプを得る
void BattleScene::getTouchCookieTag(CCPoint touchPoint, int &tag, kCookie &cookieType) {
    for (int x = 0; x < MAX_COOKIE_X ; x++) {
        for (int y = 0; y < MAX_COOKIE_Y ; y++) {
            int currentTag = getTag(x, y);
            CCNode *node = m_background->getChildByTag(currentTag);
            if (node && node->boundingBox().containsPoint(touchPoint)) {
                tag = currentTag;
                cookieType = ((CookieSprite *) node)->getCookieType();
                return;
            }
        }
    }
}

//一致するタグがList中にあればtrue
bool BattleScene::hasSameColorCookie(std::list<int> cookieTagList, int searchCookieTag) {
    list<int>::iterator it;
    for (it = cookieTagList.begin(); it != cookieTagList.end(); ++it) {
        if (*it == searchCookieTag) {
            return true;
        }
    }
    return false;
}

//basetagの上下左右のうち、同じcookieTypeのものをlistにして返す
list<int> BattleScene::getSameColorCookieTags(int baseTag, kCookie cookieType) {
    list<int> sameColorCookieTags;
    sameColorCookieTags.push_back(baseTag);

    list<int>::iterator it = sameColorCookieTags.begin();
    while (it != sameColorCookieTags.end()) {
        int tags[] = {
                *it + 100, // right cookie tag
                *it - 100, // left cookie tag
                *it + 1, // up cookie tag
                *it - 1, // downcookie tag
        };
        for (int i = 0; i < sizeof(tags) / sizeof(tags[0]); i++) {
            if (!hasSameColorCookie(sameColorCookieTags, tags[i])) {
                if (hasSameColorCookie(m_cookieTags[cookieType], tags[i])) {
                    sameColorCookieTags.push_back(tags[i]);
                }
            }
        }
        it++;
    }
    return sameColorCookieTags;
}

//cookieTagsに含まれるすべてのクッキーを削除
void BattleScene::removeCookie(list<int> cookieTags, kCookie cookieType){
    list<int>::iterator it = cookieTags.begin();
    while(it != cookieTags.end()){
        m_cookieTags[cookieType].remove(*it);
        CCNode *cookie = m_background->getChildByTag(*it);
        if(cookie){
            cookie->removeFromParentAndCleanup(true);
        }
        it++;
    }
}


bool BattleScene::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent) {
    return true;
}

void BattleScene::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent) {
}

void BattleScene::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent) {
    CCLog("ccTouchEnded");
    CCPoint touchPoint = m_background->convertTouchToNodeSpace(pTouch);
    int tag = 0;
    kCookie cookieType;
    getTouchCookieTag(touchPoint, tag, cookieType);
    if(tag != 0) {
        list<int> sameColorCookieTags = getSameColorCookieTags(tag, cookieType);
        if(sameColorCookieTags.size() > 1){
            removeCookie(sameColorCookieTags, cookieType);
        }
    }
}
