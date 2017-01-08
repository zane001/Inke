//
//  ZMSettingViewController.h
//  inke
//
//  Created by zm on 2016/12/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSettingViewController : UIViewController

-(long long)fileSizeAtPath:(NSString *)path;

-(float)folderSizeAtPath:(NSString *)path;

-(void)clearCache:(NSString *)path;

@end
