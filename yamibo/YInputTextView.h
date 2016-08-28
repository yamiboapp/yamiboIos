//
//  YTextView.h
//  yamibo
//
//  Created by shuang yang on 8/27/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFaceKeyBoardView.h"

@interface YInputTextView : UITextView

@property (nonatomic, strong)YFaceKeyBoardView * viewFaceKB;

- (void)setFaceKeyBoard;
- (void)changeKeyBoard;

@end
