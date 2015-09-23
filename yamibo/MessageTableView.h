//
//  MessageTableView.h
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"

@interface MessageTableView : YTableView

- (instancetype)initWithSectionName:(NSString *)name;
- (void)refreshData;

@end
