//
//  ZMLive.h
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMCreator.h"

@interface ZMLive : NSObject

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) ZMCreator * creator;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, assign, getter=isShow) BOOL show;


@end
