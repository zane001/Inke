//
//  ZMLaunchLiveController.m
//  inke
//
//  Created by zm on 2016/12/18.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMLaunchLiveController.h"
#import "LFLivePreview.h"

@interface ZMLaunchLiveController ()

@end

@implementation ZMLaunchLiveController

- (IBAction)closeLaunch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startLive:(id)sender {
    UIView *backView = [[UIView alloc]initWithFrame:self.view.bounds];  // 占满
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    LFLivePreview *preview = [[LFLivePreview alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:preview];
    [preview startLive];    // 开始播放直播
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
