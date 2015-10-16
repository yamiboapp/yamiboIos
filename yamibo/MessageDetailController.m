//
//  MessageDetailController.m
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageDetailController.h"
#import "MessageDetailTableView.h"

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
}
- (void)configNavigation {
    [self showCustomNavigationBackButton];
    self.title = @"与xx的对话";
}
- (void)initView {
    MessageDetailTableView *tableView = [[MessageDetailTableView alloc] initWithViewType:_viewType andToId:_toId];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView refreshData];
}

@end
