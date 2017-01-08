//
//  ZMLoginViewController.m
//  inke
//
//  Created by zm on 2016/12/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ZMUserHelper.h"
#import "ZMTabBarViewController.h"


@interface ZMLoginViewController ()

@end

@implementation ZMLoginViewController


- (IBAction)sinaLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
//            授权信息
//            NSLog(@"Sina uid: %@", resp.uid);
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
            
//            用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.gender);
            
//            // 第三方平台SDK源数据
//            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            // 存储用户登录信息
            [ZMUserHelper sharedUser].nickName = resp.name;
            [ZMUserHelper sharedUser].iconUrl = resp.iconurl;
            [ZMUserHelper saveUser];
            
            // 登录成功，进入主页面
            self.view.window.rootViewController = [[ZMTabBarViewController alloc]init];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
