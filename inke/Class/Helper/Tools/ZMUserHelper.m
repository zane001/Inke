//
//  ZMUserHelper.m
//  inke
//
//  Created by zm on 2016/12/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMUserHelper.h"

@implementation ZMUserHelper

+ (instancetype)sharedUser {
    static ZMUserHelper *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[ZMUserHelper alloc]init];
    });
    return _user;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nickName = [[NSUserDefaults standardUserDefaults]objectForKey:@"nickName"];
        _iconUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"iconUrl"];
    }
    return self;
}

+ (BOOL)isAutoLogin {
    if ([ZMUserHelper sharedUser].nickName.length == 0) {
        return NO;
    }
    return YES;
}

+ (void)saveUser {
    ZMUserHelper *user = [ZMUserHelper sharedUser];
    if ([ZMUserHelper sharedUser].nickName.length != 0) {
        [[NSUserDefaults standardUserDefaults]setObject:user.nickName forKey:@"nickName"];
        [[NSUserDefaults standardUserDefaults]setObject:user.iconUrl forKey:@"iconUrl"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

@end
