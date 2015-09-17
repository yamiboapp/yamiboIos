//
//  YColor+Ext.h
//  yamibo
//
//  Created by 李思良 on 15/9/17.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Ext)

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  根据颜色生成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  根据颜色生成图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  将十六进制颜色的字符串转化为复合iphone/ipad的颜色
 *
 *  @param hexColor 字符串为"FFFFFF"
 *
 *  @return 颜色
 */
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

@end
