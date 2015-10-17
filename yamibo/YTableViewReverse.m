//
//  YTableViewReverse.m
//  yamibo
//
//  Created by shuang yang on 10/16/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "YTableViewReverse.h"
#import "MJRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation YTableViewReverse


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        if ([self showHeaderRefresh])
        {
            self.header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
                ((MJRefreshStateHeader *)self.header).lastUpdatedTimeText = ^NSString*(NSDate *lastUpdatedTime){
                    return nil;
                };

                if (![self.footer isRefreshing]) {
                    [self loadMoreData];
                } else {
                    [self.header endRefreshing];
                }
            }];
            ((MJRefreshStateHeader *)self.header).lastUpdatedTimeLabel.hidden = YES;
            [(MJRefreshStateHeader *)self.header setTitle:@"点击或下拉加载更多" forState:MJRefreshStateIdle];
            [(MJRefreshStateHeader *)self.header setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
            [(MJRefreshStateHeader *)self.header setTitle:@"" forState:MJRefreshStatePulling];
        }
        
        if ([self showFooterRefresh])
        {
            self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                if (![self.header isRefreshing]) {
                    [self loadNewData];
                } else {
                    [self.footer endRefreshing];
                }
            }];
            self.footer.automaticallyHidden = NO;
            //[(MJRefreshAutoNormalFooter *)self.footer setTitle:@"上拉可以刷新" forState:MJRefreshStateWillRefresh];
            [(MJRefreshAutoNormalFooter *)self.footer setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
        }
        self.tableFooterView = [UIView new];
    }
    self.fd_debugLogEnabled = NO;
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
    [self.footer beginRefreshing];
}

//拉取更多数据
- (void)beginLoadMoreData
{
    [self.header beginRefreshing];
}

//停止拉取新数据
- (void)stopLoadNewData
{
    [self.footer endRefreshing];
}

//停止拉取更多数据
- (void)stopLoadMoreData
{
    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
}

//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad {
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
}

//隐藏头
- (void)hiddenFooter:(BOOL)isHidden
{
    self.footer.hidden = isHidden;
}

//隐藏尾
- (void)hiddenHeader:(BOOL)isHidden
{
    self.header.hidden = isHidden;
}

//显示无更多数据
- (void)showNoticeNoMoreData
{
    //[self.header noticeNoMoreData];
}

#pragma mark - 继承者
- (BOOL)showFooterRefresh
{
    return NO;
}

- (BOOL)showHeaderRefresh
{
    return NO;
}

- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    
}
- (BOOL)isFooterRefresh {
    return self.footer.isRefreshing;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
