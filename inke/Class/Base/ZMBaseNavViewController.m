//
//  ZMBaseNavViewController.m
//  inke
//
//  Created by zm on 05/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMBaseNavViewController.h"
#import "ZMMacros.h"

@interface ZMBaseNavViewController ()

@end

@implementation ZMBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = RGB(0, 216, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;  // 跳转之前，先将bottomBar隐藏
    }
    
    [super pushViewController:viewController animated:animated];    //进行跳转


}

@end
