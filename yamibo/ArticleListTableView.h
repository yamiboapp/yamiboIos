//
//  ArticleListTableView.h
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"

@protocol ArticleListRightMenuDelegate

- (void)reloadRightMenu:(NSDictionary*)data;
- (void)closeRightMenu;

@end

@interface ArticleListTableView : YTableView

- (instancetype)initWithForumId:(NSString *)fid andFilter:(NSString *)filter andTypeId:(NSString *)tid;
- (void)refreshData;
@property (nonatomic, weak) id<ArticleListRightMenuDelegate> rightMenuDelegate;

@end
