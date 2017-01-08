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
#define API_LiveGetTop @"api/live/gettop"

// 广告地址
#define API_Advertise @"advertise/get"

// 热门话题
#define API_TopicIndex @"api/live/topicindex"

// 附近的人
#define API_NearLocation @"api/live/near_recommend"
// ?uid=85149891&latitude=40.090562&longitude=116.413353

// 猛哥直播地址
#define Live_ZM @"rtmp://live.hkstv.hk.lxdns.com:1935/live/zm"

@end
