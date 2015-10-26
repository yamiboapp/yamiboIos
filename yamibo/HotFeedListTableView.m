//
//  HotFeedListTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "HotFeedListTableView.h"
#import "FeedListTableViewCell.h"
#import "AppManager.h"
#import "CommunicationrManager.h"
#import "HotModel.h"

@interface HotFeedListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) BOOL isNoPicMode;
@end

@implementation HotFeedListTableView

- (id)init {
    if (self = [super init]) {
        [self hiddenFooter:true];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:KFeedListTableViewCell];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:KNoImgFeedListTableViewCell];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initHeader];
    }
    return self;
}
- (void)initHeader {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, header.height)];
    [header addSubview:label];
    label.text = @"热点推荐";
    label.font = KFONT(14);
    label.textColor = KCOLOR_RED_6D2C1D;
    self.tableHeaderView = header;
}

- (void)refreshData {
    _isNoPicMode = [AppManager sharedInstance].isNoImgMode;
    [self beginLoadNewData];
}
- (void)loadData:(NSArray *)data {
    _isNoPicMode = [AppManager sharedInstance].isNoImgMode;
    _dataArray = data;
    [self reloadData];
}
- (void)loadNewData {
    [CommunicationrManager getHot:^(HotModel *model, NSString *message) {
        [self stopLoadNewData];
        if (model != nil) {
            _dataArray = model.dataText;
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
    FeedListTableViewCell *cell;
    if (_isNoPicMode) {
        cell = [tableView dequeueReusableCellWithIdentifier:KNoImgFeedListTableViewCell forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KFeedListTableViewCell forIndexPath:indexPath];
    }
    [cell loadData:_dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isNoPicMode) {
        return 75;
    } else {
        return 75;
    }
}

#pragma tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //============>
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToFeedDetail object:nil];
}

- (BOOL)showHeaderRefresh
{
    return YES;
}
@end
