//
//  HotFeedListTableView.h
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YTableView.h"
/**
 *  @author 李思良, 15-09-18
 *
 *  @brief  首页热点列表
 */
@interface HotFeedListTableView : YTableView

- (void)refreshData;

- (void)loadData:(NSArray *)data;
@end
