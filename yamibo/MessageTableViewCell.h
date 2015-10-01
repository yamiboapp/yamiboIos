//
//  MessageTableViewCell.h
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

#define KMessageTableViewCell  @"KMessageTableViewCell"

@interface MessageTableViewCell : UITableViewCell

- (void)loadData:(MessageModel *)data;

@end
