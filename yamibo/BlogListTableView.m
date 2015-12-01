//
//  BlogListTableView.m
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BlogListTableView.h"
#import "BlogListTableViewCell.h"
#import "BlogModel.h"
#import "CommunicationrManager.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface BlogListTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *userId;
@property (assign, nonatomic) BOOL isMyBlog;

@end

@implementation BlogListTableView

- (id)initWithUid:(NSString *)uid {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _dataArray = [NSMutableArray array];
        _userId = uid;
        _isMyBlog = [_userId isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
        [self registerClass:[BlogListTableViewCell class] forCellReuseIdentifier:KBlogListTableViewCell];
        self.estimatedRowHeight = 100;
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    [CommunicationrManager getBlogListWithUid:_userId andPage:1 completion:^(BlogListModel *model, NSString *message) {
        [self stopLoadNewData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            _dataArray = [NSMutableArray arrayWithArray:model.blogList];
            if ([_dataArray count] == 0) {
                [Utility showTitle:@"还没有相关的日志"];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NeedToPop object:nil];
            }
        }
        if ([model.blogList count] < 10) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];
}
- (void)loadMoreData {
    [CommunicationrManager getBlogListWithUid:_userId andPage:(int)_dataArray.count / 10 + 1 completion:^(BlogListModel *model, NSString *message) {
        [self stopLoadMoreData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray addObjectsFromArray:model.blogList];
        }
        if ([model.blogList count] < 10) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];
}
- (BOOL)showHeaderRefresh
{
    return YES;
}
- (BOOL)showFooterRefresh
{
    return YES;
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:KBlogListTableViewCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}
- (void)configureCell:(BlogListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell loadData:_dataArray[indexPath.row]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KBlogListTableViewCell];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = @{@"blogId":[[_dataArray objectAtIndex:indexPath.row] blogId], @"title":[[_dataArray objectAtIndex:indexPath.row] title]};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToBlogDetail object:nil userInfo:dic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
