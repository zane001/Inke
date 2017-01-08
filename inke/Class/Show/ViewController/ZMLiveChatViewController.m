//
//  ZMLiveChatViewController.m
//  inke
//
//  Created by zm on 10/12/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMLiveChatViewController.h"

@interface ZMLiveChatViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *peopleWatch;

@end

@implementation ZMLiveChatViewController

- (void)setLive:(ZMLive *)live {
    
    if ([live.creator.portrait containsString:@"inke"]) {
        [self.iconView downloadImage:live.creator.portrait placeholder:@"default_room"];
    } else {
        [self.iconView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.peopleWatch.text = [NSString stringWithFormat:@"%d", arc4random_uniform(10000)];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
