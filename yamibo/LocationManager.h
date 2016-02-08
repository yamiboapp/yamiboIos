//
//  LocationManager.h
//  yamibo
//
//  Created by 李思良 on 15/4/18.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 获取location成功
 */
static const int KLOCATIONSUCCESS = 0;
/**
 * 用户未开定位服务
 */

static const int KLOCATIONFAILESERVICENOTOPEND = 1;
/**
 * 用户禁止程序定位
 */
static const int KLOCATIONFAILEUSERDENIED = 2;
/**
 * 无法获取位置信息
 */

static const int KLOCATIONFAILEUNKNOW = 3;

/**
 *  @author 李思良, 15-04-24 11:04:24
 *
 *  @brief  定位服务.
 */
@interface LocationManager : NSObject
/**
 *  @author 李思良, 15-04-24 11:04:49
 *
 *  @brief  manager 单例
 *
 *  @return 
 */
+ (id)sharedInstance;

/**
 *  @author 李思良, 15-04-24 11:04:37
 *
 *  @brief  获取当前location，注意completion在stopLocation前会由于位置变动而不断产生新的调用.
 *
 *  @param completion 第一个参数为service状态，第二个参数为纬度，第三个为经度
 */
- (void)getLocation:(void (^)(int status, float latitude, float longitude))completion;

/**
 *  @author 李思良, 15-04-24 11:04:33
 *
 *  @brief  当不需要位置服务，调用此函数.
 */
- (void)stopLocation;
@end
