//
//  YTableView.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YTableView.h"
#import "MJRefresh.h"

@implementation YTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        if ([self showHeaderRefresh])
        {
            self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (![self.footer isRefreshing]) {
                    [self.footer resetNoMoreData];
                    [self loadNewData];
                } else {
                    [self.header endRefreshing];
                }
            }];
        }
        
        if ([self showFooterRefresh])
        {
            self.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                if (![self.header isRefreshing]) {
                    [self loadMoreData];
                } else {
                    [self.footer endRefreshing];
                }
            }];
            self.footer.automaticallyHidden = NO;
            [(MJRefreshAutoNormalFooter *)self.footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
            
            [self hiddenFooter:YES];
        }
        self.tableFooterView = [UIView new];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIViewController *vc;
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController *)nextResponder;
            break;
        }
    }
    if (nil != vc) {
        [vc.view endEditing:YES];
    }
    
    [self endEditing:YES];
}

//拉取新数据
- (void)beginLoadNewData
{
    [self.header beginRefreshing];
}

//拉取更多数据
- (void)beginLoadMoreData
{
    [self.footer beginRefreshing];
}

//停止拉取新数据
- (void)stopLoadNewData
{
    [self.header endRefreshing];
}

//停止拉取更多数据
- (void)stopLoadMoreData
{
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
}

//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad {
    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
}

//隐藏头
- (void)hiddenHeader:(BOOL)isHidden
{
    self.header.hidden = isHidden;
}

//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden
{
    self.footer.hidden = isHidden;
}

//显示无更多数据
- (void)showNoticeNoMoreData
{
    [self.footer noticeNoMoreData];
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    
}
- (BOOL)isHeaderRefresh {
    return self.header.isRefreshing;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
