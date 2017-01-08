//
//  UIImageView+SDWebImage.h
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DownloadImageSuccessBlock) (UIImage *image);
typedef void(^DownloadImageFailureBlock) (NSError *error);
typedef void(^DownloadImageProgressBlock) (CGFloat progress);

@interface UIImageView (SDWebImage)


// 异步加载图片
- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName;

// 异步加载图片，监听下载进度，成功或者失败
- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
              failure:(DownloadImageFailureBlock)failure
             progress:(DownloadImageProgressBlock)progress;

@end
