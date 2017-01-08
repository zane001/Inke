//
//  ZMLiveCell.m
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMLiveCell.h"

@interface ZMLiveCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *protraitView;

@end

@implementation ZMLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headView.layer.cornerRadius = 25;
    self.headView.layer.masksToBounds = YES;
}

// 重写setLive方法
- (void)setLive:(ZMLive *)live {
    _live = live;

    if ([live.creator.portrait containsString:@"inke"]) {
        
        [self.headView downloadImage:live.creator.portrait placeholder:@"default_room"];
        [self.protraitView downloadImage:live.creator.portrait placeholder:@"default_room"];

    } else if ([live.creator.portrait isEqualToString:@"focusMe"]) {
        self.headView.image = [UIImage imageNamed:@"focusMe"];
        self.protraitView.image = [UIImage imageNamed:@"focusMe"];

    } else {
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
        [self.protraitView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
    }
    self.nameLabel.text = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onlineLabel.text = [@(live.onlineUsers) stringValue];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
