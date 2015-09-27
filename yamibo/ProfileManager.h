//
//  ProfileManager.h
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  个人信息
 */
@interface ProfileManager : NSObject

/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  用户id
 */
@property (strong, nonatomic) NSString *userId;
/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  用户姓名
 */
@property (strong, nonatomic) NSString *userName;
/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  登陆token
 */
@property (strong, nonatomic) NSString *authToken;

/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  单例
 *
 *  @return 
 */
+ (instancetype)sharedInstance;

/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  检查是否登陆
 *
 *  @return
 */
- (BOOL)checkLogin;
/**
 *  @author 李思良, 15-09-19
 *
 *  @brief  登出
 */
- (void)logOut;

@end
