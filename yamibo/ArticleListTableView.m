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

@interface ArticleListTableView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) int pageNum;
@property (assign, nonatomic) int curPage;
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
        _curPage = 1;
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
            [self.tableViewDelegate reloadRightMenu:model.articleTypes];
            _pageNum = [model.articleNum intValue] / 10;
            [self.tableViewDelegate setPageNumber:1 andTotalPages:_pageNum];
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
- (void)nextPage {
    if (_curPage * 10 < [_dataArray count]) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_curPage*10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
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
            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_curPage * 10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
    }
}
- (void)previousPage {
    if (_curPage == 1) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(_curPage - 2) * 10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
- (BOOL)showHeaderRefresh
{
    return YES;
}
- (BOOL)showFooterRefresh
{
    return YES;
}
#pragma mark UITableViewDataSource UITableViewDelegate

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
    [self.tableViewDelegate closeRightMenu];
    
    ArticleModel *article = [_dataArray objectAtIndex:indexPath.row];
    NSDictionary *dic = @{@"threadID": article.articleId,
                              @"authorID": article.authorId};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToFeedDetail object:nil userInfo:dic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([[self indexPathsForVisibleRows] count] > 0) {
        NSIndexPath *firstVisibleIndexPath = [[self indexPathsForVisibleRows] objectAtIndex:0];
        _curPage = (int)(firstVisibleIndexPath.row / 10 + 1);
        [self.tableViewDelegate setPageNumber:_curPage andTotalPages:_pageNum];
    }
}

@end
