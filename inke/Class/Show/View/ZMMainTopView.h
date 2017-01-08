//
//  ZMMainTopView.h
//  inke
//
//  Created by zm on 26/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface ZMMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles tapView:(MainTopBlock)block;

- (void)scrolling:(NSInteger)tag;

@end
