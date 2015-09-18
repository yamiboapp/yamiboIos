//
//  HomeController.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "HomeController.h"
#import "HomeHotView.h"
/**
 *  @author 李思良, 15-08-17
 *
 *  @brief  首页
 */
@interface HomeController ()
@property (strong, nonatomic)   HomeHotView *hotView;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    [self initSwitch];
}
- (void)initSwitch {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"热门", @"全部"]];
    self.navigationItem.titleView = segment;
    segment.tintColor = KCOLOR_YELLOW_FFEDBE;
    segment.selectedSegmentIndex = 0;
    [segment setWidth:SCALE_NUM(120)];
}
- (void)initView {
    _hotView = [[HomeHotView alloc] init];
    [self.view addSubview:_hotView];
    [_hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)onNavigationLeftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}

@end
