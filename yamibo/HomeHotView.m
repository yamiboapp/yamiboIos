//
//  HomeHotView.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "HomeHotView.h"
#import "HomeBannerView.h"
#import "HotFeedListTableView.h"
#import "AppManager.h"

@interface HomeHotView()
@property (strong, nonatomic) HomeBannerView *banner;
@property (strong, nonatomic) HotFeedListTableView *tableView;
@end

@implementation HomeHotView
- (id)init {
    if (self = [super init]) {
        _banner = [[HomeBannerView alloc] init];
        [self addSubview:_banner];
        [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(_banner.mas_width).multipliedBy(0.37);
        }];
        _tableView = [[HotFeedListTableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_banner.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        [_tableView refreshData];
    }
    return self;
}
- (void)viewWillAppear {
    BOOL isNopic = [AppManager sharedInstance].isNoImgMode;
    if (isNopic) {
        _banner.hidden = true;
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_banner);
            make.left.right.bottom.equalTo(self);
        }];
    } else {
        _banner.hidden = false;
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_banner.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];

    }
}
@end
