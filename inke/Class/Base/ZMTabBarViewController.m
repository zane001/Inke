//
//  ZMTabBarViewController.m
//  inke
//
//  Created by zm on 05/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMTabBarViewController.h"
#import "ZMTabBar.h"
#import "ZMMacros.h"
#import "ZMBaseNavViewController.h"
#import "ZMLaunchLiveController.h"

@interface ZMTabBarViewController () <ZMTabBarDelegate>

@property (nonatomic, strong) ZMTabBar *zmTabBar;

@end

@implementation ZMTabBarViewController

- (void)tabBar:(ZMTabBar *)tabBar clickButton:(ZMItemType)idx {
    if (idx != ZMItemTypeLaunch) {
        self.selectedIndex = idx - ZMItemTypeLive;
        return;
    }
    ZMLaunchLiveController *launch = [[ZMLaunchLiveController alloc]init];
    [self presentViewController:launch animated:YES completion:nil];
}

- (ZMTabBar *)zmTabBar {
    if (!_zmTabBar) {
        _zmTabBar = [[ZMTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _zmTabBar.delegate = self;
    }
    return _zmTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载控制器
    [self configViewControllers];
    // 加载TabBar
    [self.tabBar addSubview:self.zmTabBar];
}

- (void)configViewControllers {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"ZMMainViewController", @"ZMMeViewController"]];
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *vcName = array[i];
        UIViewController *vc = [[NSClassFromString(vcName)alloc]init];
        ZMBaseNavViewController *nav = [[ZMBaseNavViewController alloc]initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
