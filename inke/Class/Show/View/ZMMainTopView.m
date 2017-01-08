//
//  ZMMainTopView.m
//  inke
//
//  Created by zm on 26/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMMainTopView.h"

@interface ZMMainTopView ()

@property (nonatomic, strong) UIView *lineView; // 下划线
@property (nonatomic, copy) MainTopBlock mainTopBlock;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation ZMMainTopView

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles tapView:(MainTopBlock)block {
    
    self = [super initWithFrame:frame]; //重写时，不要忘记此句
    self.mainTopBlock = block;
    
    CGFloat btnW = self.width / titles.count;
    CGFloat btnH = self.height;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *vcNames = titles[i];
        [titleBtn setTitle:vcNames forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = i;
        [self.buttons addObject:titleBtn];
        [self addSubview:titleBtn];
        
        
        if (i == 1) {
            CGFloat h = 2;
            CGFloat y = 40;
            [titleBtn.titleLabel sizeToFit];
            self.lineView = [[UIView alloc]init];
            self.lineView.backgroundColor = [UIColor whiteColor];
            self.lineView.width = titleBtn.titleLabel.width;
            self.lineView.height = h;
            self.lineView.top = y;
            self.lineView.centerX = titleBtn.centerX;
            [self addSubview:self.lineView];
        }
    }
    return self;
}

- (void)scrolling:(NSInteger)tag {
    UIButton *btn = self.buttons[tag];
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.centerX = btn.centerX;
    }];
}

- (void)titleClick:(UIButton *)button {
    self.mainTopBlock(button.tag);
    [self scrolling:button.tag];
}

@end
