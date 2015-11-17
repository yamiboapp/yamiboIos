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
*  @author 李思良, 15-04-24 11:04:58
*
*  @brief  字符串md5编码.
*
*  @return 
*/
- (NSString*)md5sum;

@end

@interface NSString (Localize)
/**
 *  @author 李思良, 15-04-24 11:04:13
 *
 *  @brief  字符串国际化.
 *
 *  @return 
 */
- (NSString*)localize;

@end

@interface NSString (Convert)
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  根据用户需求将简体转繁体
 *
 *  @return 转换后的string
 */
- (NSString *)convert;

@end

@interface NSString (formatLastPost)
/**
 *  @author Shuang Yang, 15-10-31
 *
 *  @brief  格式化最新回复时间
 *
 *  @return 
 */
- (NSString*)formatLastPost;

@end

@interface NSString (toLocalTime)
/**
 *  @author Shuang Yang, 15-10-31
 *
 *  @brief  讲北京时间转换为系统当地时间
 *
 *  @return 转换后的当地时间string
 */
- (NSString*)toLocalTime;

@end

@interface NSString (stringFromHTML)
/**
 *  @author Shuang Yang, 15-11-10
 *
 *  @brief  Decode simple HTML tags (no images/links)
 *
 *  @return Plain text
 */
- (NSString*)stringFromHTML;
@end

@interface NSData (MD5)

/**
 *  @author 李思良, 15-04-24 11:04:33
 *
 *  @brief  NSData byte编码后的md5.
 *
 *  @return 
 */

- (NSString*)md5;

@end
