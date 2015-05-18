//
//  Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author lsl, 15-04-24 11:04:15
 *
 *  @brief  常用合法性检测.
 */
@interface Utility : NSObject

+ (BOOL)isValidEmail:(NSString*)email;

+ (BOOL)isValidMobile:(NSString*)mobile;

@end
