//
//  AppManager.h
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  app的一些用户配置信息
 */
@interface AppManager : NSObject
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  单例
 *
 *  @return
 */
+ (instancetype)sharedInstance;
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  是否开启繁体模式
 */
@property (assign, nonatomic) BOOL isTradionChinese;

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  是否开启无图模式
 */
@property (assign, nonatomic) BOOL isNoImgMode;
/**
 *  @author Shuang Yang, 15-11-09
 *
 *  @brief  是否开启夜间模式
 */
@property (assign, nonatomic) BOOL isNightMode;


@end
