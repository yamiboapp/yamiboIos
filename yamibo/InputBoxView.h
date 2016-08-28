//
//  ReplyView.h
//  yamibo
//
//  Created by shuang yang on 3/5/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^InputBoxSendMessageBlock)(NSString *message);

@interface InputBoxView : UIView

@property(nonatomic, strong) InputBoxSendMessageBlock sendMessageBlock;
@end

