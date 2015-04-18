//
//  LocationManager.h
//  yamibo
//
//  Created by 李思良 on 15/4/18.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 定位服务
 */
@interface LocationManager : NSObject


+ (id)sharedInstance;

/**
 * 获取当前location，注意completion在stopLocation前会由于位置变动而产生新的调用
 */
- (void)getLocation:(void (^)(int status, float latitude, float longitude))completion;

/**
 * 当不需要位置服务，调用此函数
 */
- (void)stopLocation;
@end
