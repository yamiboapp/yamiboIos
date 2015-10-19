//
//  MessageTableView.h
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"
#import "MessageModel.h"

#define kMessageSelectionIndexKey            @"kMessageSelectionIndexKey"

@interface MessageTableView : YTableView

- (instancetype)initWithViewType:(MessageViewType)type;
- (void)refreshData;

@end
