//
//  ZMTabBar.h
//  inke
//
//  Created by zm on 05/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMTabBar;
typedef NS_ENUM(NSUInteger, ZMItemType) {
    ZMItemTypeLaunch = 10,   //启动播放直播
    ZMItemTypeLive = 100, //展示直播
    ZMItemTypeMe
};

typedef void(^TabBlock)(ZMTabBar *tabBar, ZMItemType idx); //定义block

@protocol ZMTabBarDelegate <NSObject>

- (void)tabBar:(ZMTabBar *) tabBar clickButton:(ZMItemType) idx;  //代理

@end

@interface ZMTabBar : UIView

@property (nonatomic, weak) id <ZMTabBarDelegate> delegate;
@property (nonatomic, copy) TabBlock block;


@end
