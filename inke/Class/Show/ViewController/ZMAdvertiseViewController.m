//
//  ZMAdvertiseViewController.m
//  inke
//
//  Created by zm on 2016/12/25.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMAdvertiseViewController.h"
#import "ZMLiveHandler.h"
#import "ZMAdvertise.h"
#import "ZMCacheHelper.h"
#import "SDWebImageManager.h"

static NSInteger showTime = 5;
static BOOL isClickAdvertise = false;

@interface ZMAdvertiseViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backView; // 广告图片
@property (weak, nonatomic) IBOutlet UILabel *timeoutLabel; // 倒计时

@property (nonatomic, strong)dispatch_source_t timer;

@property (nonatomic, copy)NSString *advertiseUrl;  // 广告地址
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation ZMAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAd];
    [self downloadAd];
    [self startTimer];
    
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    self.view.frame = [UIScreen mainScreen].bounds;
//}

//+ (instancetype)loadAdvertiseView {
//    return [[[NSBundle mainBundle]loadNibNamed:@"ZMAdvertiseView" owner:self options:nil]lastObject];
//}

// 展示广告
- (void)showAd {
    UITapGestureRecognizer *timeoutRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTimeout)];
    [self.timeoutLabel addGestureRecognizer:timeoutRecognizer]; // 给Label添加点击事件
    self.timeoutLabel.userInteractionEnabled = YES; // Label可以被点击
    
    UITapGestureRecognizer *enterAdvertiseRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterAdvertiseAct)];
    [self.backView addGestureRecognizer:enterAdvertiseRecognizer];  // 点击广告图片事件
    self.backView.userInteractionEnabled = YES;
    
    
    NSString *fileName = [ZMCacheHelper getAdvertise];
    //    NSString *filePath = [NSString stringWithFormat:@"%@%@", IMAGE_HOST, fileName];
    UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:fileName];
    // 如果存在，就展示；否则隐藏
    if (lastCacheImage) {
        self.backView.image = lastCacheImage;
    } else {
        self.view.hidden = YES;
        
    }
}

// 提前关闭广告的倒计时
- (void)closeTimeout {
    dispatch_source_cancel(self.timer);
    [self.view removeFromSuperview];
}

// 点击广告进入活动页面
- (void)enterAdvertiseAct {
    isClickAdvertise = true;
    dispatch_source_cancel(self.timer);
    [self.backView removeFromSuperview];

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40)];
    self.webView.userInteractionEnabled = YES;
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.advertiseUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}


// 下载广告图片
- (void)downloadAd {
    [ZMLiveHandler executeGetAdvertiseTaskWithSuccess:^(id obj) {
        ZMAdvertise *adv = obj;
        self.advertiseUrl = adv.link;
        NSURL *imageURL = [NSURL URLWithString:adv.image];  //映客图片有时自带host
        //        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, adv.image]];
        //        NSURL *imageURL = [NSURL URLWithString:obj];
        [[SDWebImageManager sharedManager]loadImageWithURL:imageURL options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            [ZMCacheHelper setAdvertise:adv.image]; // 存储图片
            //            NSLog(@"广告图片下载成功");
        }];
    } failure:^(id obj) {
        
    }];
}

// 开始倒计时，使用dispatch_source
- (void)startTimer {
    __block NSUInteger timeout = showTime;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    self.timer = timer; // 给自身View添加定时器
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
            });
        } else {
            // 在主线程修改timeLabel
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.timeoutLabel.text = [NSString stringWithFormat:@"跳过 %zd", timeout];
            });
            timeout--;
        }
        
    });
    
    dispatch_resume(timer);
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}


@end
