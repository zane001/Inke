//
//  MJExtensionConfig.m
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "ZMCreator.h"
#import "ZMLive.h"

@implementation MJExtensionConfig

+ (void)load {
    
    // 将json中的id转为model中的ID
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    // 将json中description转为model中的desc
    [ZMCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"desc" : @"description"};
    }];
    
    // 将model中的驼峰命名转为json中的下划线命名
    [ZMCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [ZMLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];

}

@end
