//
//  MessageController.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageController.h"
#import "MessageTableView.h"

@interface MessageController ()

@end

@implementation MessageController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];

}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"消息";
}
- (void)initView {
    MessageTableView *PrivateMessageView = [[MessageTableView alloc]initWithSectionName:@"私人信息"];
    [self.view addSubview:PrivateMessageView];
    [PrivateMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [PrivateMessageView refreshData];
}

- (void)onNavigationLeftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}

@end
