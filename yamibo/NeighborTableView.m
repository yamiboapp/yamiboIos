//
//  NeighborTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "NeighborTableView.h"
#import "NeighborTableViewCell.h"
@interface NeighborTableView()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation NeighborTableView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _dataArray = [NSMutableArray array];
        [self registerClass:[NeighborTableViewCell class] forCellReuseIdentifier:KNeighborTableViewCell];
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
    return 75.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NeighborTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KNeighborTableViewCell];
    [cell loadData];
    return cell;
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
