//
//  YFaceKeyBoardView.h
//  yamibo
//
//  Created by shuang yang on 8/27/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GrayColor [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ToolBarHeight 40

typedef void (^FaceKeyBoardBlock)(NSString * faceName,NSInteger faceTag);
typedef void (^FaceKeyBoardSendBlock)(void);
typedef void (^FaceKeyBoardDeleteBlock)(void);

/**
 *  @author Shuang Yang, 16-08-28
 *
 *  @brief 论坛自定义表情的键盘
 */
@interface YFaceKeyBoardView : UIView

- (void)setFaceKeyBoardBlock:(FaceKeyBoardBlock)block;
- (void)setFaceKeyBoardSendBlock:(FaceKeyBoardSendBlock)block;
- (void)setFaceKeyBoardDeleteBlock:(FaceKeyBoardDeleteBlock)block;

@end