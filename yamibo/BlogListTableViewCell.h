//
//  BlogListTableViewCell.h
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogModel;

#define KBlogListTableViewCell @"KBlogListTableViewCell"

@interface BlogListTableViewCell : UITableViewCell
- (void)loadData:(BlogModel *)data;
@end
