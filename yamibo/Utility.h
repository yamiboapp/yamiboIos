//
//  Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 常用合法性检测.
 */
@interface Utility : NSObject

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidMobile:(NSString *)mobile;

@end
