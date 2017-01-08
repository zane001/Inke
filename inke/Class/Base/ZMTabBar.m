//
//  ZMTabBar.m
//  inke
//
//  Created by zm on 05/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMTabBar.h"

@interface ZMTabBar ()

@property (nonatomic, strong) UIImageView *tabBarBgView;    // 背景图片
@property (nonatomic, strong) NSArray *dataList;    // item数据源
@property (nonatomic, strong) UIButton *lastItem;   // 保存上一次点击的Button
@property (nonatomic, strong) UIButton *cameraButton; // 启动直播按钮

@end

@implementation ZMTabBar

- (UIImageView *)tabBarBgView {
    // 懒加载
    if (!_tabBarBgView) {
        _tabBarBgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBarBgView;
}

- (NSArray *)dataList {
    // 懒加载
    if (!_dataList) {
        _dataList = @[@"tab_live", @"tab_me"];
    }
    return _dataList;
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        // 自定义Button
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        _cameraButton.tag = ZMItemTypeLaunch;
    }
    return _cameraButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 装载背景
        [self addSubview:self.tabBarBgView];
        
        // 装载item
        for (NSInteger i = 0; i < self.dataList.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.dataList[i]stringByAppendingString:@"_p"]] forState:   UIControlStateSelected];    // 点击图片
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = ZMItemTypeLive + i;
            item.adjustsImageWhenHighlighted = NO;
            
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
            }
            [self addSubview:item];
        }
        
        // 装载直播按钮
        [self addSubview:self.cameraButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width / self.dataList.count;
    self.tabBarBgView.frame = self.bounds;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag - ZMItemTypeLive) * width, 0, width, self.frame.size.height);
        }
    }
    
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 50);
}

- (void)clickItem:(UIButton *)button {
    // 如果遵循代理协议，那么实现代理的方法
    if ([self.delegate respondsToSelector:@selector(tabBar:clickButton:)]) {
        [self.delegate tabBar:self clickButton:button.tag];
    }
    
    if (self.block) {
        self.block(self, button.tag);
    }
    
    if (button.tag == ZMItemTypeLaunch) {
        return;
    }
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //  设置点击动画
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
    

}
@end
