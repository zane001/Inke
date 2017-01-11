//
//  APIConfig.h
//  inke
//
//  Created by zm on 26/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

#define SERVER_HOST @"http://service.ingkee.com/"

//#define IMAGE_HOST @"http://img.meelive.cn/"
#define IMAGE_HOST @"http://img2.inke.cn/"

// 首页数据
#define API_LiveGetTop @"api/live/gettop?lc=000006&cc=TG0001&cv=IK3.8.40_Iphone&proto=7&idfa=14DEB88&idfv=887DB1B63&devi=4a292f409c&osversion=ios_10.00000&ua=iPhone7_2&imei=&imsi=&uid=100726&sid=9A0N0i0VS&conn=wifi&mtid=20bb840d&mtxid=fc5161ca&logid=34,13&count=5&multiaddr=1&s_sg=7ccf7a6ae5d&s_sc=100&s_st=1484144026"

// 广告地址
#define API_Advertise @"advertise/get"

// 热门话题
#define API_TopicIndex @"api/live/topicindex"

// 附近的人
#define API_NearLocation @"api/live/near_recommend"
// ?uid=85149891&latitude=40.090562&longitude=116.413353

// 猛哥直播地址
#define Live_ZM @"rtmp://live.hkstv.hk.lxdns.com:1935/live/zm"

// 搜索，修改keyword即可搜索指定内容
#define SEARCH @"api/user/search?lc=00006&cc=TG0001&cv=IK3.8.40_Iphone&proto=7&idfa=1469041DEB88&idfv=862D69E3&devi=9483987c409c&osversion=ios_10.200000&ua=iPhone7_2&imei=&imsi=&uid=100726&sid=9BS&conn=wifi&mtid=20d&mtxid=c7d71ca&logid=34,133&start=0&count=25&keyword=888&s_sg=875113bb&s_sc=100&s_st=1484144026"

@end
