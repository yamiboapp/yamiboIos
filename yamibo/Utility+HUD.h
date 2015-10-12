//
//  YProgressHUD.h
//  YFramework
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface Utility(HUD)


+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title;

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated;

/**
 *  @author 李思良, 15-08-21
 *
 *  @brief  在window最上层显示一个菊花形hud
 *
 *  @param title hud的title
 *
 *  @return
 */
+ (MBProgressHUD *)showHUDWithTitle;
+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title;

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title animated:(BOOL)animated;

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title;

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title hideAfter:(NSTimeInterval)afterSecond;

+ (void)hiddenProgressHUD;

+ (void)hiddenProgressHUD:(UIView *)inView;

/**
 *  @author 李思良, 15-08-21
 *
 *  @brief  在window最上层显示纯文本hud，默认1s后消失
 *
 *  @param title 标题
 *
 *  @return
 */
+ (MBProgressHUD *)showTitle:(NSString *)title;

+ (MBProgressHUD *)showTitle:(NSString *)title hideAfter:(NSTimeInterval)afterSecond;;
@end
