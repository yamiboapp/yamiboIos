//
//  UIImage+Utility.m
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Stretch)

- (UIImage *)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)stretchableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        return [self resizableImageWithCapInsets:capInsets];
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

- (UIImage *)stretchableImageByCenter
{
    CGFloat leftCapWidth = floorf(self.size.width/2);
    if (leftCapWidth == self.size.width/2) {
        leftCapWidth--;
    }

    CGFloat topCapHeight = floorf(self.size.height/2);
    if (topCapHeight == self.size.height/2) {
        topCapHeight--;
    }

    return [self stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByHeightCenter
{
    CGFloat topCapHeight = floorf(self.size.height/2);
    if (topCapHeight == self.size.height/2) {
        topCapHeight--;
    }

    return [self stretchableImageWithLeftCapWidth:0 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByWidthCenter
{
    CGFloat leftCapWidth = floorf(self.size.width/2);
    if (leftCapWidth == self.size.width/2) {
        leftCapWidth--;
    }

    return [self stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:0];
}

- (NSInteger)rightCapWidth
{
    return (NSInteger)self.size.width - (self.leftCapWidth + 1);
}

- (NSInteger)bottomCapHeight
{
    return (NSInteger)self.size.height - (self.topCapHeight + 1);
}

@end

@implementation UIImage (OrientationFix)

- (UIImage *)orientationFixedImage
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }

    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
        }
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored: {
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.f);
            transform = CGAffineTransformRotate(transform, M_PI_2);
        }
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, 0.f, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
        }
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: {
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
        }
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            transform = CGAffineTransformTranslate(transform, self.size.height, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
        }
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }

    CGContextRef context = CGBitmapContextCreate(NULL, self.size.width, self.size.height, CGImageGetBitsPerComponent(self.CGImage), 0.f, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(context, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(context, CGRectMake(0.f, 0.f, self.size.height, self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(context, CGRectMake(0.f, 0.f, self.size.width, self.size.height), self.CGImage);
            break;
    }

    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return image;
}


@end

@implementation UIImage (WithColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1,1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
