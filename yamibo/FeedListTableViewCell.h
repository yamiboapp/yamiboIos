//
//  FeedListTableViewCell.h
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataImg;

#define KFeedListTableViewCell      @"KFeedListTableViewCell"
#define KNoImgFeedListTableViewCell @"KNoImgFeedListTableViewCell"
/**
 *  @author 李思良, 15-09-18
 *
 *  @brief  帖子列表cell
 */
@interface FeedListTableViewCell : UITableViewCell

- (void)loadData:(DataImg *)data;

@end
