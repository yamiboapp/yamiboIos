//
//  CollectController.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "CollectController.h"
#import "CollectTableView.h"

@interface CollectController()

@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    [self initView];
}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"收藏";
}
- (void)initView {
    CollectTableView *collectList = [[CollectTableView alloc] init];
    [self.view addSubview:collectList];
    [collectList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [collectList refreshData];
}
- (void)onNavigationLeftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
@end
