//
//  ForumListTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ForumListTableView.h"
#import "ForumListTableViewCell.h"
#import "CommunicationrManager.h"
#import "ForumModel.h"

@interface ForumListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSArray *dataArray;
@end

@implementation ForumListTableView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ForumListTableViewCell class] forCellReuseIdentifier:KForumListTableViewCell];
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}
- (void)loadNewData {
    [CommunicationrManager getForumList:^(ForumListModel *model, NSString *message) {
        [self stopLoadNewData];
        if (model != nil) {
            _dataArray = model.forumList;
            [self reloadData];
        }
    }];
}
#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumListTableViewCell *cell = [self dequeueReusableCellWithIdentifier:KForumListTableViewCell];
    [cell loadData:_dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *forumIdList = [_dataArray valueForKey:@"forumId"];
    NSMutableArray *forumNameList = [_dataArray valueForKey:@"forumName"];
    NSDictionary *dic = @{
                          @"forumId":[_dataArray[indexPath.row] forumId],
                          @"forumName":[_dataArray[indexPath.row] forumName],
                          @"forumIdList":forumIdList,
                          @"forumNameList":forumNameList
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToForumDetail object:nil userInfo:dic];
}
- (BOOL)showHeaderRefresh
{
    return YES;
}
@end
