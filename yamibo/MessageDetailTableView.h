//
//  MessageDetailTableView.h
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"
#import "MessageModel.h"

@interface MessageDetailTableView : YTableView

- (instancetype)initWithViewType:(MessageViewType)type andToId:(NSInteger)toId;
- (void)refreshData;

@end




