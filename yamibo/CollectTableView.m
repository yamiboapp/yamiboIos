//
//  CollectTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "CollectTableView.h"
#import "CollectTableViewCell.h"
#import "CommunicationrManager.h"
#import "ThreadFavoriteModel.h"

@interface CollectTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation CollectTableView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _dataArray = [NSMutableArray array];
        [self registerClass:[CollectTableViewCell class] forCellReuseIdentifier:KCollectTableViewCell];
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    [CommunicationrManager getFavoriteList:1 completion:^(ThreadFavoriteListModel *model, NSString *message) {
        [self stopLoadNewData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            _dataArray = [NSMutableArray arrayWithArray:model.favList];
        }
        if (model.favList.count < 20) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];
}
- (void)loadMoreData {
    [CommunicationrManager getFavoriteList:(int)_dataArray.count / 20 + 1 completion:^(ThreadFavoriteListModel *model, NSString *message) {
        [self stopLoadMoreData];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray addObjectsFromArray:model.favList];
        }
        if (model.favList.count < 20) {
            [self hiddenFooter:true];
        } else {
            [self hiddenFooter:false];
        }
        [self reloadData];
    }];
}
#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCollectTableViewCell];
    [cell loadData:_dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRow:indexPath];
    }
}
- (void)deleteRow:(NSIndexPath *)indexPath {
    [Utility showHUDWithTitle:@"正在删除"];
    [CommunicationrManager delFavorite:[_dataArray[indexPath.row] favId] completion:^(NSString *message) {
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
