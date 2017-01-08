//
//  UIImageView+SDWebImage.m
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageLowPriority | SDWebImageRetryFailed];
}


- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName success:(DownloadImageSuccessBlock)success failure:(DownloadImageFailureBlock)failure progress:(DownloadImageProgressBlock)progress {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(receivedSize * 1.0 / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            failure(error);
        } else {
            success(image);
            self.image = image;
        }
    }];
}



@end
