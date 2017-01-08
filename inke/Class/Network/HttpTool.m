//
//  HttpTool.m
//  inke
//
//  Created by zm on 26/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

static NSString *kBaseUrl = SERVER_HOST;

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

// 单例
@implementation AFHttpClient

+ (instancetype)sharedClient {
    static AFHttpClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        // 接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", @"image/gif", nil];
        
        // 设置超时时间
        client.requestSerializer.timeoutInterval = 10;
        
        // 安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return client;
}

@end


@implementation HttpTool

// get请求
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient]GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

// post请求
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient]POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

// 下载文件
+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress {
 
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient]downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 获取沙盒cache路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager]URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
    }];
    [downloadTask resume];
}

// 上传图片
+ (void)uploadWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)imageKey image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress {
    
    // 获取完整的url路径
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSData *data = UIImagePNGRepresentation(image);
    [[AFHttpClient sharedClient]POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
