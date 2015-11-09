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
#import "HMSegmentedControl.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailController:) name:KNotification_ToMessageDetail object:nil];
}
- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    [self showCustomNavigationButtonWithTitle:@"新建"];
    self.title = @"消息";
}
- (void)initView {
    _publicMessageView = [[MessageTableView alloc]initWithViewType:MessagePublic];
    [self.view addSubview:_publicMessageView];
    [_publicMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(44);
    }];
    //[_publicMessageView refreshData];
    
    _privateMessageView = [[MessageTableView alloc]initWithViewType:MessagePrivate];
    [self.view addSubview:_privateMessageView];
    [_privateMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(44);
    }];
    [_privateMessageView refreshData];
}
- (void)initSwitch {
    UIView *back = [[UIView alloc]init];
    back.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [self.view addSubview:back];
    
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"公共消息", @"私人消息"]];
    segment.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                   KCOLOR_GRAY, NSForegroundColorAttributeName,
                                   KFONT(15), NSFontAttributeName,
                                   nil];
    segment.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           KCOLOR_RED_6D2C1D, NSForegroundColorAttributeName,
                                           KFONT(15), NSFontAttributeName,
                                           nil];
    segment.selectionIndicatorColor = KCOLOR_RED_6D2C1D;
    segment.backgroundColor = [UIColor clearColor];
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segment.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -40);
    segment.selectedSegmentIndex = 1;

    [back addSubview:segment];
    
    // constrains
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(43);
    }];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    
    [segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)changeSeg:(HMSegmentedControl *)seg {
    long index = (long)seg.selectedSegmentIndex;
        
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
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
- (void)pushToDetailController:(NSNotification*)notification{
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
