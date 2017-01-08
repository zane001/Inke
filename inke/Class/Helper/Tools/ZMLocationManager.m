//
//  ZMLocationManager.m
//  inke
//
//  Created by zm on 12/12/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZMLocationManager () <CLLocationManagerDelegate>

@property(nonatomic, strong)CLLocationManager *locManager;
@property(nonatomic, copy)LocationBlock block;

@end

@implementation ZMLocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc]init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"请开启定位服务");
        } else {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString *lati = [NSString stringWithFormat:@"%@", @(coor.latitude)];
    NSString *longi = [NSString stringWithFormat:@"%@", @(coor.longitude)];
    self.block(lati, longi);
    [ZMLocationManager sharedManager].lati = lati;
    [ZMLocationManager sharedManager].longi = longi;
    [self.locManager stopUpdatingLocation];
}

- (void)getGPS:(LocationBlock)block {
    self.block = block;    // 初始化block
    [self.locManager startUpdatingLocation];
}

// 单例
+ (instancetype)sharedManager {
    static ZMLocationManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZMLocationManager alloc]init];
    });
    return _manager;
}

@end
