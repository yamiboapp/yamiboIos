//
//  CollectTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "CollectTableView.h"
#import "CollectTableViewCell.h"

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
        [self stopLoadNewData];
        [self reloadData];
        [self hiddenFooter:false];
    });
}
- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_dataArray addObjectsFromArray:@[@"", @""]];
        [self stopLoadMoreData];
        [self reloadData];
    });
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
    [cell loadData];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
