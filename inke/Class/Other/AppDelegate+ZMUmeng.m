//
//  AppDelegate+ZMUmeng.m
//  inke
//
//  Created by zm on 2016/12/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AppDelegate+ZMUmeng.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation AppDelegate (ZMUmeng)

- (void)setupUmeng {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58588670f43e48624c002bf0"];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2478577805"  appSecret:@"b46a11d0c67711dd8eea3a611a47cc18" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}


@end
