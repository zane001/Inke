//
//  ZMLocationManager.h
//  inke
//
//  Created by zm on 12/12/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString *lati, NSString *longi);

@interface ZMLocationManager : NSObject 

+ (instancetype)sharedManager;

- (void)getGPS:(LocationBlock) block;   // 获取经纬度

@property (nonatomic, copy)NSString *lati;
@property (nonatomic, copy)NSString *longi;

@end
