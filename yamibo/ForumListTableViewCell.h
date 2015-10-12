//
//  ForumListTableViewCell.h
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumModel;
#define KForumListTableViewCell @"KForumListTableViewCell"

@interface ForumListTableViewCell : UITableViewCell

- (void)loadData:(ForumModel *)data;

@end
