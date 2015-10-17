//
//  YTableViewReverse.h
//  yamibo
//
//  Created by shuang yang on 10/16/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTableViewReverse : UITableView

//拉取新数据
- (void)beginLoadNewData;
//拉取更多数据
- (void)beginLoadMoreData;
//停止拉取新数据
- (void)stopLoadNewData;
//停止拉取更多数据
- (void)stopLoadMoreData;
//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad;
//隐藏头
- (void)hiddenHeader:(BOOL)isHidden;
//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden;
//显示无更多数据
- (void)showNoticeNoMoreData;

- (BOOL)isHeaderRefresh;
@end