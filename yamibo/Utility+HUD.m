//
//  YProgressHUD.m
//  YFramework
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "Utility+HUD.h"
#import "MBProgressHUD+BWMExtension.h"
@implementation Utility(HUD)

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    return [MBProgressHUD bwm_showHUDAddedTo:view title:title animated:animated];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title {
    return [Utility showHUDAddedTo:view title:title animated:true];
}

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title animated:(BOOL)animated {
    return [Utility showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] title:title animated:animated];
}

+ (MBProgressHUD *)showHUDWithTitle {
    return [self showHUDWithTitle:@"请等待..."];
}

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title {
    return [Utility showHUDWithTitle:title animated:true];
}

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    if (title.length == 0) {
        return nil;
    }
    return [MBProgressHUD bwm_showTitle:title toView:view hideAfter:afterSecond];
}

+ (void)hiddenProgressHUD
{
    [self hiddenProgressHUD:[[[UIApplication sharedApplication] delegate] window]];
}

+ (void)hiddenProgressHUD:(UIView *)inView
{
    [MBProgressHUD hideAllHUDsForView:inView animated:NO];
}

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title {
    return [Utility showTitleOn:view title:title hideAfter:1];
}
+ (MBProgressHUD *)showTitle:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    return [Utility showTitleOn:[[[UIApplication sharedApplication] delegate] window] title:title hideAfter:afterSecond];
}
+ (MBProgressHUD *)showTitle:(NSString *)title {
    return [Utility showTitleOn:[[[UIApplication sharedApplication] delegate] window] title:title hideAfter:1];
}
@end
