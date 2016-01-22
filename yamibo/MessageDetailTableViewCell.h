//
//  MessageDetailTableViewCell.h
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivateMessageDetailModel;
@class PublicMessageDetailModel;
#import "YPostContentView.h"
#define KMessageDetailTableViewCell_In  @"KMessageDetailTableViewCell_In"
#define KMessageDetailTableViewCell_Out  @"KMessageDetailTableViewCell_Out"

@interface MessageDetailTableViewCell : UITableViewCell

- (void)loadPrivateData:(PrivateMessageDetailModel *)data;
- (void)loadPublicData:(PublicMessageDetailModel *)data;
- (void)cellBgColor:(BOOL)longPressed;
- (void)aaa;
@property (strong, nonatomic) YPostContentView *contentLabel;
@property (assign, nonatomic, getter=getHeight) CGFloat height;
@property (assign, nonatomic) int pmid;

@end
