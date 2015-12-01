//
//  BlogControllerViewController.m
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BlogListController.h"
#import "BlogListTableView.h"
#import "BlogDetailController.h"

@interface BlogListController ()
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userName;
@property (assign, nonatomic) BOOL isMyBlog;
@end

@implementation BlogListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToPreviousController:) name:kNotification_NeedToPop object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailController:) name:KNotification_ToBlogDetail object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configNavigation {
    [self showCustomNavigationBackButton];
    if (_isMyBlog) {
        self.title = @"我的日志";
    } else {
        self.title = [NSString stringWithFormat:@"%@的日志", _userName];
    }
}
- (void)initView {
    BlogListTableView *blogList = [[BlogListTableView alloc] initWithUid:_userId];
    [self.view addSubview:blogList];
    [blogList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [blogList refreshData];
}
- (void)loadDate:(NSDictionary *)data {
    _userId = data[@"userId"];
    _userName = data[@"userName"];
    _isMyBlog = [_userId isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
}
#pragma mark - Observer
- (void)popToPreviousController:(NSNotification *)notification {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushToDetailController:(NSNotification *)notification {
    BlogDetailController *detailController = [[BlogDetailController alloc] init];
    [detailController loadDate:notification.userInfo];
    detailController.title = self.title;
    [self.navigationController pushViewController:detailController animated:YES];
}
@end
