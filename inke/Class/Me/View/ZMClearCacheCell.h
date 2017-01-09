//
//  ZMClearCacheCell.h
//  inke
//
//  Created by zm on 2017/1/9.
//  Copyright © 2017年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMClearCacheCell : UITableViewCell

-(long long)fileSizeAtPath:(NSString *)path;

-(float)folderSizeAtPath:(NSString *)path;

-(void)clearCache;

@end
