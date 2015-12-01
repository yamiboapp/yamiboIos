//
//  BlogListTableView.h
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"

@interface BlogListTableView : YTableView
- (id)initWithUid:(NSString *)uid;
- (void)refreshData;
@end
