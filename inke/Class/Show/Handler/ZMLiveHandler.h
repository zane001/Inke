//
//  ZMLiveHandler.h
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMBaseHandler.h"

@interface ZMLiveHandler : ZMBaseHandler

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success
                                 failure:(FailureBlock)failure;

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success
                                  failure:(FailureBlock)failure;

+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success
                                   failure:(FailureBlock)failure;
@end
