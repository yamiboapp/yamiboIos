//
//  Constance.h
//  yamibo
//
//  Created by 李思良 on 15/4/18.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

/**
 *  @author 李思良, 15-04-24 11:04:47
 *
 *  @brief  常用全局变量色等，请定义在此处.
 */
#ifndef yamibo_Constance_h
#define yamibo_Constance_h

#include "ColorConstance.h"
#include "NotificationConstance.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_HEIGHT == 736.0)

#define SCALE_NUM(number)   number * SCREEN_WIDTH / 375

#endif
