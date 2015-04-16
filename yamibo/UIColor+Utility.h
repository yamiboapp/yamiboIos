//
//  UIColor+Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

- (NSString *)hexColor;

+ (UIColor *)colorWithRGBHex:(NSInteger)rgbHex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGBHex:(NSInteger)rgbHex;
+ (UIColor *)whiteColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)blackColorWithAlpha:(CGFloat)alpha;

@end