//
//  MenuController.h
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "BaseViewController.h"

#define kLeftDrawerSelectionIndexKey            @"LeftDrawerSelectionIndex"

typedef NS_ENUM(NSInteger, CenterControllerIndex) {
    CenterControllerProfile = -1,
    CenterControllerHome,
};
@interface MenuController : BaseViewController

@end
