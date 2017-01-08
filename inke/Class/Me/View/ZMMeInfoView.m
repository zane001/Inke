//
//  ZMMeInfoView.m
//  inke
//
//  Created by zm on 2016/12/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMMeInfoView.h"

@implementation ZMMeInfoView

+ (instancetype)loadInfoView {
    return [[[NSBundle mainBundle]loadNibNamed:@"ZMMeInfoView" owner:self options:nil]lastObject];
}

@end
