//
//  HttpTool.h
//  inke
//
//  Created by zm on 26/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock) (id json);
typedef void (^HttpFailureBlock) (NSError *error);
typedef void (^HttpDownloadProgressBlock) (CGFloat progress);
typedef void (^HttpUploadProgressBlock) (CGFloat progress);

@interface HttpTool : NSObject


// get网络请求
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

// post网络请求
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

// 下载文件
+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress;

// 上传文件
+ (void)uploadWithPath:(NSString *)path
                params:(NSDictionary *)params
             thumbName:(NSString *)imageKey
                 image:(UIImage *)image
               success:(HttpSuccessBlock)success
               failure:(HttpFailureBlock)failure
              progress:(HttpUploadProgressBlock)progress;

@end
