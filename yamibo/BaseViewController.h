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
*  @author 李思良, 15-04-24 11:04:56
*
*  @brief  类似android的快速消息提醒
*
*  @param message 消息内容
*/
- (void)showMessage:(NSString*)message;

@end
