//
//  MessageDetailController.h
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"

@interface MessageDetailController : BaseViewController
@property (assign, nonatomic) NSInteger toId;
@property (assign, nonatomic) MessageViewType viewType;
@end
