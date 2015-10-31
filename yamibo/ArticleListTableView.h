//
//  ArticleListTableView.h
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"

@interface ArticleListTableView : YTableView

- (instancetype)initWithForumId:(NSString *)fid;
- (void)refreshData;

@end
