//
//  ZMGoodVoiceCell.m
//  inke
//
//  Created by zm on 2017/1/14.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ZMGoodVoiceCell.h"
#import "Masonry.h"

@interface ZMGoodVoiceCell ()


@property (nonatomic, strong)UIButton *moreBtn;
@property (nonatomic, strong)UIImageView *portrait;
@property (nonatomic, strong)NSMutableArray *portraits;
@property (nonatomic, strong)UILabel *watchNumber;
@property (nonatomic, strong)NSMutableArray *watchNumbers;


@end

@implementation ZMGoodVoiceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    
    self.moreBtn = [[UIButton alloc]init];
    [self.moreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
    [self.moreBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    self.portraits = [NSMutableArray array];
    self.watchNumbers = [NSMutableArray array];
    
    for (int i = 1; i <= 3; i++) {
        
        self.portrait = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"img%d", i]]];
        self.portrait.layer.cornerRadius = 10;
        self.portrait.layer.masksToBounds = YES;
        [self.portraits addObject:self.portrait];
        [self addSubview:self.portrait];
        
        self.watchNumber = [[UILabel alloc]init];
        self.watchNumber.text = @"1000人";
        [self.watchNumbers addObject:self.watchNumber];
        [self addSubview:self.watchNumber];
    }
    
//    约束视图对象只有在被addSubview之后，才能给视图添加约束
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreBtn];
    
    return self;
}



// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(padding.left);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@10);

    }];

    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-padding.right);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    for (int i = 0; i < 3; i++) {
     
        UIImageView *view = self.portraits[i];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            // 低优先级
            make.size.equalTo(@((SCREEN_WIDTH - 40) / 3)).priorityLow();

            if (i == 0) {
                make.left.equalTo(self.mas_left).offset(padding.left);
            } else {
                UIImageView *view = self.portraits[i - 1];
                make.left.equalTo(view.mas_right).offset(padding.right);
            }
        
        }];

       
        [self.watchNumbers[i] mas_makeConstraints:^(MASConstraintMaker *make) {

            UIImageView *view = self.portraits[i];
            make.centerX.equalTo(self.portraits[i]);
            make.top.equalTo(view.mas_bottom).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.equalTo(@100);
            make.height.equalTo(@10);
        }];
     
    }


    [super updateConstraints];
}

@end
