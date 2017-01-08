//
//  ZMLiveHandler.m
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMLiveHandler.h"
#import "HttpTool.h"
#import "ZMLive.h"
#import "ZMLocationManager.h"
#import "ZMAdvertise.h"

@implementation ZMLiveHandler

/**
 *  获取热门直播
 */
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        if ([json[@"dm_errer"] integerValue]) {
            failure(json);
        } else {
            // 如果返回信息正确，数据解析
            NSArray *lives =  [ZMLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取附近直播
 */
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    
    ZMLocationManager *manager = [ZMLocationManager sharedManager];
    NSDictionary *params = @{@"uid":@"85149891", @"latitude":manager.lati, @"longitude":manager.longi};

    [HttpTool getWithPath:API_NearLocation params:params success:^(id json) {
        if ([json[@"dm_errer"] integerValue]) {
            failure(json);
        } else {
            // 如果返回信息正确，数据解析
            NSArray *lives =  [ZMLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);

        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  获取广告
 */
+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            failure(json);
        } else {
            ZMAdvertise *adv = [ZMAdvertise mj_objectWithKeyValues:json[@"resources"][0]];    // api暂时无法获取广告
//            NSString *url = @"http://img2.inke.cn/MTQ3ODQyNjY4OTkxOSMxOTEjanBn.jpg";
            success(adv);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
