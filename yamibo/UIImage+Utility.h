//
//  UIImage+Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (Stretch)

- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)stretchableImageWithCapInsets:(UIEdgeInsets)capInsets;
- (UIImage *)stretchableImageByCenter;
- (UIImage *)stretchableImageByHeightCenter;
- (UIImage *)stretchableImageByWidthCenter;

@property (nonatomic, readonly) NSInteger rightCapWidth;
@property (nonatomic, readonly) NSInteger bottomCapHeight;

@end

@interface UIImage (OrientationFix)

- (UIImage *)orientationFixedImage;

@end

@interface UIImage (WithColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end