//
//  MenuController.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "MenuController.h"
#import "MenuTableViewCell.h"
#import "ProfileManager.h"
@interface MenuController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *itemNames;
@property (strong, nonatomic) NSArray *iconImgs;
@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    _itemNames = @[@"论坛", @"收藏", @"消息", @"附近的人", @"设置"];
    _iconImgs = @[[UIImage imageNamed:@"menu-forum"], [UIImage imageNamed:@"menu-favor"], [UIImage imageNamed:@"menu-msg"], [UIImage imageNamed:@"menu-neighbor"], [UIImage imageNamed:@"menu-set"]];
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
        menuItem = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMenuTableHeadCell];
    } else {
        menuItem = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMenuTableViewCell];
        [menuItem loadTitle:_itemNames[indexPath.row - 1] andIcon:_iconImgs[indexPath.row - 1]];
    }
    return menuItem;
}
#pragma tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = (int)indexPath.row;
    if (index == 0 && ![[ProfileManager sharedInstance] checkLogin]) {
        index = -1;
    }
    NSDictionary *dic = @{kLeftDrawerSelectionIndexKey:@(index)};
    [[NSNotificationCenter defaultCenter] postNotificationName:KChangeCenterViewNotification object:nil userInfo:dic];
}
@end
