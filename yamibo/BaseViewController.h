//
//  BaseViewController.h
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 李思良, 15-04-24 11:04:52
 *
 *  @brief  建议将其作为基类.
 */
@interface BaseViewController : UIViewController

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  导航左按钮
 */
@property (strong, nonatomic) UIButton *navigationLeftButton;
/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  导航右按钮
 */
@property (strong, nonatomic) UIButton *navigationRightButton;


/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  导航栏左侧显示返回按钮
 */
- (void)showCustomNavigationBackButton;

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  导航栏左侧显示菜单按钮
 */
- (void)showCustomNavigationMenuButton;

/**
 *  @author 李思良, 15-09-17
 *
 *  @brief  导航栏右侧，更多按钮
 */
- (void)showCustomNavigationMoreButton;
/**
 *  @author 杨爽, 15-10-01 21:10:40
 *
 *  @brief  导航栏右侧，自定义按钮名
 */
- (void)showCustomNavigationButtonWithTitle:(NSString *)title;
/**
 *  @author sssixone, 15-11-01 04:11:37
 *
 *  @brief  导航栏右侧, 收藏按钮
 */
- (void)showCustomNavigationCollectButton;
/**
*  @author 李思良, 15-04-24 11:04:56
*
*  @brief  类似android的快速消息提醒
*
*  @param message 消息内容
*/
- (void)showMessage:(NSString*)message;


@end
