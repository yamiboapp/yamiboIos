//
//  ArticleListTableView.h
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableView.h"

@protocol ArticleListTabelViewDelegate

- (void)reloadRightMenu:(NSDictionary*)data;
- (void)closeRightMenu;
- (void)setPageNumber:(NSInteger)page andTotalPages:(NSInteger)pageNum;

@end

@interface ArticleListTableView : YTableView

- (instancetype)initWithForumId:(NSString *)fid andFilter:(NSString *)filter andTypeId:(NSString *)tid;
- (void)refreshData;
- (void)nextPage;
- (void)previousPage;

@property (nonatomic, weak) id<ArticleListTabelViewDelegate> tableViewDelegate;

@end
