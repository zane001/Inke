//
//  ZMCacheHelper.m
//  inke
//
//  Created by zm on 2016/12/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMCacheHelper.h"
#define advertiseImage @"advertiseImage"

@implementation ZMCacheHelper

// 使用KVC
+ (NSString *)getAdvertise {
    return [[NSUserDefaults standardUserDefaults]objectForKey:advertiseImage];
}

+ (void)setAdvertise:(NSString *)adImage {
    [[NSUserDefaults standardUserDefaults]setObject:adImage forKey:advertiseImage];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}


@end
