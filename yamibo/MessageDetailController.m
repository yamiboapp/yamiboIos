//
//  MessageDetailController.m
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageDetailController.h"
#import "MessageDetailTableView.h"
@interface MessageDetailController()
@property (assign, nonatomic) MessageViewType viewType;
@property (assign, nonatomic) NSInteger detailId;
@property (assign, nonatomic) NSString *detailName;
@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
}
- (void)configNavigation {
    [self showCustomNavigationBackButton];
    if (_viewType == MessagePrivate) {
        self.title = [NSString stringWithFormat:@"与 %@ 的对话", _detailName];
    } else if (_viewType == MessagePublic) {
        self.title = [NSString stringWithFormat:@"来自 %@ 的消息", _detailName];
    }
}
- (void)initView {
    MessageDetailTableView *tableView = [[MessageDetailTableView alloc] initWithViewType:_viewType andDetailId:_detailId];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView refreshData];
}
- (void)loadData:(NSDictionary *)data {
    _viewType = [data[@"viewType"] intValue];
    _detailId = [data[@"detailId"] intValue];
    _detailName = data[@"detailName"];
}
@end
