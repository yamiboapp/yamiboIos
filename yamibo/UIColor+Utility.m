//
//  UIColor+Utility.m
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (HexColor)

- (NSString *)hexColor
{
    if (self == [UIColor whiteColor]) {
        return @"#ffffff";
    }

    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;

    [self getRed:&red green:&green blue:&blue alpha:&alpha];

    int redDec = (int)(red*255);
    int greenDec = (int)(green*255);
    int blueDec = (int)(blue*255);

    NSString *hexColor = [NSString stringWithFormat:@"#%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];

    return hexColor;
}


+ (UIColor *)colorWithRGBHex:(NSInteger)rgbHex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbHex & 0xFF0000) >> 16))/255.f green:((float)((rgbHex&0xFF00) >> 8))/255.f blue:((float)(rgbHex&0xFF))/255.f alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(NSInteger)rgbHex
{
    return [self colorWithRGBHex:rgbHex alpha:1.f];
}

+ (UIColor *)whiteColorWithAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRGBHex:0xffffff alpha:alpha];
}

+ (UIColor *)blackColorWithAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRGBHex:0x000000 alpha:alpha];
}

@end
