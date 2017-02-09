//
//  ZMTodayRecommendCell.m
//  inke
//
//  Created by zm on 2017/1/14.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ZMTodayRecommendCell.h"

@interface ZMTodayRecommendCell ()
   
@property (nonatomic, strong) UIImageView *portrait;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UIButton *addButton;


@end

@implementation ZMTodayRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(!self) return nil;
    
    self.portrait = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img1"]];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"你的名字";
    self.nameLabel.textColor = [UIColor lightGrayColor];
    
    self.descLabel = [[UILabel alloc]init];
    self.descLabel.text = @"你的简介";
    self.descLabel.textColor = [UIColor lightGrayColor];
    
    self.genderLabel = [[UILabel alloc]init];
    self.genderLabel.text = @"你的性别";
    self.genderLabel.textColor = [UIColor lightGrayColor];
    
    self.rankLabel = [[UILabel alloc]init];
    self.rankLabel.text = @"你的等级";
    self.rankLabel.textColor = [UIColor lightGrayColor];
    
    self.addButton = [[UIButton alloc]init];
    
    [self addSubview:self.portrait];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.genderLabel];
    [self addSubview:self.rankLabel];
    [self addSubview:self.addButton];
    
    
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(padding.left);
        make.top.equalTo(self.mas_top).offset(5);
        make.size.equalTo(@(30));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portrait.mas_right).offset(5);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.equalTo(@(100));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.portrait.mas_right).offset(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.width.equalTo(@(200));
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(30);
        make.top.equalTo(self.mas_top).offset(5);
        make.width.equalTo(@(100));
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.genderLabel.mas_right).offset(5);
        make.width.equalTo(@(100));
    }];
    
    [super updateConstraints];
    
}




@end
