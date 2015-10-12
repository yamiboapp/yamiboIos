//
//  MessageTableViewCell.h
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivateMessageModel;
@class PublicMessageModel;

#define KMessageTableViewCell  @"KMessageTableViewCell"

@interface MessageTableViewCell : UITableViewCell

- (void)loadPrivateData:(PrivateMessageModel *)data;
- (void)loadPublicData:(PublicMessageModel *)data;

@end
