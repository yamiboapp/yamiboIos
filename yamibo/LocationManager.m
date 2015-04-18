//
//  LocationManager.m
//  yamibo
//
//  Created by 李思良 on 15/4/18.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

/**
 * 获取location成功
 */
static const int KLOCATIONSUCCESS               = 0;
/**
 * 用户未开定位服务
 */
static const int KLOCATIONFAILESERVICENOTOPEND  = 1;
/**
 * 用户禁止程序定位
 */
static const int KLOCATIONFAILEUSERDENIED       = 2;
/**
 * 无法获取位置信息
 */
static const int KLOCATIONFAILEUNKNOW           = 3;


@interface LocationManager()<CLLocationManagerDelegate>
{
    CLLocationManager *locationService;
    void (^block)(int status, float latitude, float longitude);
}

@end

@implementation LocationManager

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id instance = nil;
    
    dispatch_once(&once, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    
    return instance;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        locationService = [[CLLocationManager alloc] init];
        if([locationService respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [locationService requestWhenInUseAuthorization]; //使用中授权
        }
        locationService.delegate = self;
        locationService.distanceFilter = 10;
        locationService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    
    return self;
}

- (void)getLocation:(void (^)(int status, float latitude, float longitude))completion
{
    block = [completion copy];
    if (![CLLocationManager locationServicesEnabled]) {
        block(KLOCATIONFAILESERVICENOTOPEND, 0, 0);
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        block(KLOCATIONFAILEUSERDENIED, 0, 0);
        return;
    }
    [locationService startUpdatingLocation];
    NSLog(@"已开启定位");
}
- (void)stopLocation
{
    block = nil;
    [locationService stopUpdatingLocation];
    NSLog(@"定位已关闭");
}
#pragma mark CLLocationManagerDelegate<br>/**<br>* 获取经纬度<br>*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    NSLog(@"定位成功：纬度:%f, 经度:%f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
    if (block) {
        NSLog(@"执行定位回调");
        block(KLOCATIONSUCCESS, currLocation.coordinate.latitude,currLocation.coordinate.longitude);
    }
}
/**
 *定位失败，回调此方法
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
    block(KLOCATIONFAILEUNKNOW, 0, 0);
}
@end
