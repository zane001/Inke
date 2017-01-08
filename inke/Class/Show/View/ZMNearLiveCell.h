//
//  ZMNearLiveCell.h
//  inke
//
//  Created by zm on 12/12/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMLive.h"

@interface ZMNearLiveCell : UICollectionViewCell

@property (nonatomic, strong)ZMLive *live;

- (void)showAnimation;
@end
