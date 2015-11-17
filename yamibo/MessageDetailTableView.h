//
//  MessageDetailTableView.h
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableViewReverse.h"
#import "MessageModel.h"

@interface MessageDetailTableView : YTableViewReverse

- (instancetype)initWithViewType:(MessageViewType)type andDetailId:(NSInteger)detailId;
- (void)refreshData;

@end




