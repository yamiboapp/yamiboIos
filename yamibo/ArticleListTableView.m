//
//  ArticleListTableView.m
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleListTableView.h"
#import "ArticleListTableViewCell.h"
#import "CommunicationrManager.h"
#import "ArticleModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ArticleListTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) int perPage;
@property (strong, nonatomic) NSString *forumId;
@property (strong, nonatomic) NSString *typeId;
@property (strong, nonatomic) NSString *filter;
@property (strong, nonatomic) NSDictionary *articleTypes;

@end

@implementation ArticleListTableView

- (instancetype)initWithForumId:(NSString *)fid andFilter:(NSString *)filter andTypeId:(NSString *)tid {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _forumId = fid;
        _typeId = tid;
        _filter = filter;
        [self registerClass:[ArticleListTableViewCell class] forCellReuseIdentifier:KArticleListTableViewCell];
        self.estimatedRowHeight = 200;
    }
    return self;
}
- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    [CommunicationrManager getArticleList:_forumId andPage:1 andFilter:_filter andTypeId:_typeId andPerPage:@"10" completion:^(ArticleListModel *model, NSString *message) {
        [self stopLoadNewData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            _dataArray = [NSMutableArray arrayWithArray:model.articleList];
            _articleTypes = [NSDictionary dictionaryWithDictionary:model.articleTypes];
            [self.rightMenuDelegate reloadRightMenu:model.articleTypes];
        }
        if (model.articleList.count < 10) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];
}
- (void)loadMoreData {
    [CommunicationrManager getArticleList:_forumId andPage:(int)_dataArray.count / 10 + 1 andFilter:_filter andTypeId:_typeId andPerPage:@"10" completion:^(ArticleListModel *model, NSString *message) {
        [self stopLoadMoreData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray addObjectsFromArray:model.articleList];
        }
        if (model.articleList.count < 10) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:KArticleListTableViewCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    return 70;
}
- (void)configureCell:(ArticleListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    ArticleModel *article = _dataArray[indexPath.row];
    NSString *typeId = article.typeId;
    NSString *typeName = _articleTypes[typeId];
    [cell loadData:_dataArray[indexPath.row] andTypeName:typeName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KArticleListTableViewCell];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.rightMenuDelegate closeRightMenu];
    
    ArticleModel *article = [_dataArray objectAtIndex:indexPath.row];
    NSDictionary *dic = @{@"threadID": article.articleId,
                              @"authorID": article.authorId};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToFeedDetail object:nil userInfo:dic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)showHeaderRefresh
{
    return YES;
}
- (BOOL)showFooterRefresh
{
    return YES;
}

@end
