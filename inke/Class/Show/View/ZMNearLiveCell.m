//
//  ZMNearLiveCell.m
//  inke
//
//  Created by zm on 12/12/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMNearLiveCell.h"

@interface ZMNearLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation ZMNearLiveCell

- (void)setLive:(ZMLive *)live {
    _live = live;
    [self.headView downloadImage:live.creator.portrait placeholder:@"default_room"];
    self.distanceLabel.text = live.distance;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showAnimation {
    
    if (self.live.isShow) { // 如果已经展示，则不进行下面的动画效果
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1); // 先缩小
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1); // 在0.5秒时间内，恢复原来大小
        self.live.show = YES;
    }];
}

@end
