//
//  NSObject+Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 * 字符串md5编码.
 */
- (NSString *)md5sum;

@end

/**
 * 字符串国际化.
 */
@interface NSString (Localize)

- (NSString *)localize;

@end

/**
 * NSData按照byte编码.
 */
@interface NSData (MD5)

- (NSString *)md5;

@end
