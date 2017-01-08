//
//  ZMUserHelper.h
//  inke
//
//  Created by zm on 2016/12/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMUserHelper : NSObject

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *iconUrl;

// 单例
+ (instancetype)sharedUser;

// 当前用户是否登录
+ (BOOL)isAutoLogin;

// 存储当前用户信息
+ (void)saveUser;

@end
