//
//  MessageDetailTableView.m
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageDetailTableView.h"
#import "MessageDetailTableViewCell.h"
#import "CommunicationrManager.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface MessageDetailTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) MessageViewType viewType;
@property (assign, nonatomic) NSInteger toId;
@property (assign, nonatomic) float msgCount;
@property (assign, nonatomic) float perPage;
@property (assign, nonatomic) int currentPage;

@end

@implementation MessageDetailTableView
- (instancetype)init
{
    return [self initWithViewType:MessagePrivate andToId:0];
}
- (instancetype)initWithViewType:(MessageViewType)type andToId:(NSInteger)toId{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _viewType = type;
        _toId = toId;
        _dataArray = [NSMutableArray array];
        [self registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:KMessageDetailTableViewCell_In];
        [self registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:KMessageDetailTableViewCell_Out];
        self.estimatedRowHeight = 200;
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageDetailList:1 toId:_toId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _msgCount = [model.count intValue];
                _perPage = [model.perPage intValue];
                _currentPage = ceil(_msgCount / _perPage);
                [CommunicationrManager getPrivateMessageDetailList:_currentPage toId:_toId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
                    [self stopLoadNewData];
                    if (message != nil) {
                        [Utility showTitle:message];
                    } else {
                        _dataArray = [NSMutableArray arrayWithArray:model.msgList];
                    }
                    if (model.msgList.count < _perPage) {
                        [self hiddenHeader:YES];
                    } else {
                        [self hiddenHeader:NO];
                    }
                    [self hiddenFooter:YES];
                    [self reloadData];
                }];
            }
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager getPublicMessageList:1 completion:^(PublicMessageListModel *model, NSString *message) {
            [self stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _dataArray = [NSMutableArray arrayWithArray:model.msgList];
            }
            if (model.msgList.count < 20) {
                [self hiddenFooter:true];
            } else {
                [self hiddenFooter:false];
            }
            [self reloadData];
        }];
    }
    
}
- (void)loadMoreData {
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageDetailList:--_currentPage toId:_toId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            [self stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                //[_dataArray addObjectsFromArray:model.msgList];
                [_dataArray replaceObjectsInRange:NSMakeRange(0,0)
                                withObjectsFromArray:model.msgList];
            }
            if (model.msgList.count < _perPage) {
                [self hiddenHeader:YES];
            } else {
                [self hiddenHeader:NO];
            }
            [self reloadData];
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager getPublicMessageList:(int)_dataArray.count / 20 + 1 completion:^(PublicMessageListModel *model, NSString *message) {
            [self stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                [_dataArray addObjectsFromArray:model.msgList];
            }
            if (model.msgList.count < 20) {
                [self hiddenFooter:true];
            } else {
                [self hiddenFooter:false];
            }
            [self reloadData];
        }];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)configureCell:(MessageDetailTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (_viewType == MessagePrivate) {
        [cell loadPrivateData:_dataArray[indexPath.row]];
    } else if (_viewType == MessagePublic) {
        [cell loadPublicData:_dataArray[indexPath.row]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    MessageDetailTableViewCell *cell;
    if (data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_In];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_Out];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    if (data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_In cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_Out cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deleteRow:indexPath];
}

- (void)deleteRow:(NSIndexPath *)indexPath {
    [Utility showHUDWithTitle:@"正在删除"];
    /*[CommunicationrManager delMessage:[_dataArray[indexPath.row] pmId] completion:^(NSString *message) {
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];*/
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)showHeaderRefresh
{
    return YES;
}
- (BOOL)showFooterRefresh
{
    return YES;
}

@end
