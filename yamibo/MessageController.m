//
//  MessageController.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageController.h"
#import "MessageTableView.h"
#import "MessageDetailController.h"

@interface MessageController ()

@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) UIView *tintLine;
@property (strong, nonatomic) MessageTableView *privateMessageView;
@property (strong, nonatomic) MessageTableView *publicMessageView;

@end

@implementation MessageController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initSwitch];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToDetail:) name:KNotification_ToMessageDetail object:nil];
}
- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    [self showCustomNavigationNewButton];
    self.title = @"消息";
}
- (void)initView {
    _privateMessageView = [[MessageTableView alloc]initWithViewType:MessagePrivate];
    [self.view addSubview:_privateMessageView];
    [_privateMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(43);
    }];
    
    _publicMessageView = [[MessageTableView alloc]initWithViewType:MessagePublic];
    [self.view addSubview:_publicMessageView];
    [_publicMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(43);
    }];
    [_publicMessageView refreshData];
}
- (void)initSwitch {
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"公共消息", @"私人消息"]];
    UIView *back = [[UIView alloc]init];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(43);
    }];
    back.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    
    [back addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    segment.tintColor = [UIColor clearColor];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     KCOLOR_RED_6D2C1D, NSForegroundColorAttributeName,
                                     KFONT(15), NSFontAttributeName,
                                     KCOLOR_RED_6D2C1D, NSUnderlineColorAttributeName,
                                     
                                     nil]
                           forState:UIControlStateSelected];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     KCOLOR_GRAY, NSForegroundColorAttributeName,
                                     KFONT(15), NSFontAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    segment.selectedSegmentIndex = 0;
    
    _container = [[UIView alloc] init];
    [segment addSubview:_container];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(segment);
        make.left.centerX.equalTo(segment);
        make.height.mas_equalTo(4);
    }];
    [segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
    
    [self initTintLine];
}
- (void)initTintLine {
    _tintLine = [[UIView alloc] init];
    [_container addSubview:_tintLine];
    [_tintLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.top.bottom.equalTo(_container);
        make.centerX.equalTo(_container).multipliedBy(0.5);
    }];
    _tintLine.backgroundColor = KCOLOR_RED_6D2C1D;
}
- (void)changeSeg:(UISegmentedControl *)seg {
    int index = (int)seg.selectedSegmentIndex;
    
    [self changeTint:index];
    
    if (index == 0) {
        _publicMessageView.hidden = false;
        _privateMessageView.hidden = true;
        [_publicMessageView refreshData];
    } else {
        _publicMessageView.hidden = true;
        _privateMessageView.hidden = false;
        [_privateMessageView refreshData];
    }
}
- (void)changeTint:(NSInteger)index {
    if (index == 0) {
        [_tintLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(90);
            make.top.bottom.equalTo(_container);
            make.centerX.equalTo(_container).multipliedBy(0.5);
        }];
    } else {
        [_tintLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(90);
            make.top.bottom.equalTo(_container);
            make.centerX.equalTo(_container).multipliedBy(1.5);
        }];
    }
    [_tintLine setNeedsLayout];
    [UIView animateWithDuration:0.3 animations:^{
        [_tintLine layoutIfNeeded];
    }];
}
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
- (void)navigateToDetail:(NSNotification*)notification{
    MessageViewType viewType = [[notification.userInfo objectForKey:@"messageViewType"] intValue];
    NSDictionary* dic = @{
                          @"viewType":[NSNumber numberWithInt:viewType],
                          @"detailId":[notification.userInfo objectForKey:@"detailId"],
                          @"detailName":[notification.userInfo objectForKey:@"detailName"]
                          };
    
    MessageDetailController *detailContronller = [[MessageDetailController alloc] init];
    [detailContronller loadData:dic];
    [self.navigationController pushViewController:detailContronller animated:YES];
}

@end
