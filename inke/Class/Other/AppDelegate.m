//
//  AppDelegate.m
//  inke
//
//  Created by zm on 31/10/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "AppDelegate.h"
#import "ZMTabBarViewController.h"
#import "ZMLocationManager.h"
#import "ZMAdvertiseViewController.h"
#import "AppDelegate+ZMUmeng.h"
#import "ZMLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ZMUserHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置友盟
    [self setupUmeng];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *mainVC;
    // 如果用户已经登录，那么进入主界面，否则进入登录页面
    if ([ZMUserHelper isAutoLogin]) {
        mainVC = [[ZMTabBarViewController alloc]init];
    } else {
        mainVC = [[ZMLoginViewController alloc]init];
    }
    
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    [[ZMLocationManager sharedManager]getGPS:^(NSString *lati, NSString *longi) {
//        NSLog(@"latitude: %@, longtitude: %@", lati, longi);
    }];
    ZMAdvertiseViewController *advVC = [[ZMAdvertiseViewController alloc]init];
    [self.window addSubview:advVC.view];
    
    
    
    return YES;
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


@end
