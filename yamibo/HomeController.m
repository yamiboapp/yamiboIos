//
//  HomeController.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "HomeController.h"
#import "HomeHotView.h"
#import "ForumListTableView.h"
/**
 *  @author 李思良, 15-08-17
 *
 *  @brief  首页
 */
@interface HomeController ()
@property (strong, nonatomic)   HomeHotView *hotView;
@property (strong, nonatomic)   ForumListTableView *forumList;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_hotView viewWillAppear];
}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    [self initSwitch];
}
- (void)initSwitch {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"热门", @"全部"]];
    self.navigationItem.titleView = segment;
    segment.tintColor = KCOLOR_YELLOW_FDF5D8;
    segment.selectedSegmentIndex = 0;
    [segment setWidth:SCALE_NUM(120)];
    [segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
}
- (void)initView {
    _hotView = [[HomeHotView alloc] init];
    [self.view addSubview:_hotView];
    [_hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _forumList = [[ForumListTableView alloc] init];
    [self.view addSubview:_forumList];
    [_forumList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _forumList.hidden = true;
    [_forumList refreshData];
    
}
- (void)changeSeg:(UISegmentedControl *)seg {
    int index = (int)seg.selectedSegmentIndex;
    if (index == 0) {
        _hotView.hidden = false;
        _forumList.hidden = true;
    } else {
        _hotView.hidden = true;
        _forumList.hidden = false;
    }
}
- (void)onNavigationLeftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}

@end