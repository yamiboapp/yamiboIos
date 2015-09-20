//
//  MenuController.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "MenuController.h"
#import "MenuTableViewCell.h"
@interface MenuController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *itemNames;
@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    _itemNames = @[@"论坛", @"收藏", @"消息", @"附近的人", @"设置"];
}

- (void)initTableView {
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = false;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    [_tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:KMenuTableViewCell];
    [_tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:KMenuTableHeadCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return SCALE_NUM(235);
    }
    return 51;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *menuItem;
    if (indexPath.row == 0) {
        menuItem = [tableView dequeueReusableCellWithIdentifier:KMenuTableHeadCell];
    } else {
        menuItem = [tableView dequeueReusableCellWithIdentifier:KMenuTableViewCell];
        [menuItem loadTitle:_itemNames[indexPath.row - 1] andIcon:nil];
    }
    return menuItem;
}
#pragma tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = @{kLeftDrawerSelectionIndexKey:@(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:KChangeCenterViewNotification object:nil userInfo:dic];
}
@end
