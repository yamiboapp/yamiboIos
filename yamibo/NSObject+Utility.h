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
*  @author lsl, 15-04-24 11:04:58
*
*  @brief  字符串md5编码.
*
*  @return 
*/
- (NSString*)md5sum;

@end

@interface NSString (Localize)
/**
 *  @author lsl, 15-04-24 11:04:13
 *
 *  @brief  字符串国际化.
 *
 *  @return 
 */
- (NSString*)localize;

@end

@interface NSData (MD5)

/**
 *  @author lsl, 15-04-24 11:04:33
 *
 *  @brief  NSData byte编码后的md5.
 *
 *  @return 
 */

- (NSString*)md5;

@end
