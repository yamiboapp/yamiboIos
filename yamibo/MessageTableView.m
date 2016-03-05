//
//  MessageTableView.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageTableViewCell.h"
#import "CommunicationrManager.h"

@interface MessageTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) MessageViewType viewType;
@property (assign, nonatomic) int msgCount;
@property (assign, nonatomic) int perPage;
@end

@implementation MessageTableView

- (instancetype)init
{
    return [self initWithViewType:MessagePrivate];
}
- (instancetype)initWithViewType:(MessageViewType)type {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _viewType = type;
        _dataArray = [NSMutableArray array];
        [self registerClass:[MessageTableViewCell class] forCellReuseIdentifier:KMessageTableViewCell];
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageList:1 completion:^(PrivateMessageListModel *model, NSString *message) {
            [self stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _dataArray = [NSMutableArray arrayWithArray:model.msgList];
                _msgCount = [model.count intValue];
                _perPage = [model.perPage intValue];
                if (model.msgList.count < _perPage || _msgCount == _perPage) {
                    [self hiddenFooter:YES];
                } else {
                    [self hiddenFooter:NO];
                }
            }
            [self reloadData];
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager getPublicMessageList:1 completion:^(PublicMessageListModel *model, NSString *message) {
            [self stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _dataArray = [NSMutableArray arrayWithArray:model.msgList];
                _msgCount = [model.count intValue];
                _perPage = [model.perPage intValue];
                if (model.msgList.count < _perPage || _msgCount == _perPage) {
                    [self hiddenFooter:YES];
                } else {
                    [self hiddenFooter:NO];
                }
            }
            [self reloadData];
        }];
    }

}
- (void)loadMoreData {
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageList:(int)_dataArray.count / _perPage + 1 completion:^(PrivateMessageListModel *model, NSString *message) {
            [self stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                       NSMakeRange(0, model.msgList.count)];
                [_dataArray insertObjects:model.msgList atIndexes:indexes];
            }
            if (model.msgList.count < _perPage) {
                [self hiddenFooter:YES];
            } else {
                [self hiddenFooter:NO];
            }
            [self reloadData];
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager getPublicMessageList:(int)_dataArray.count / _perPage + 1 completion:^(PublicMessageListModel *model, NSString *message) {
            [self stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                       NSMakeRange(0, model.msgList.count)];
                [_dataArray insertObjects:model.msgList atIndexes:indexes];
            }
            if (model.msgList.count < _perPage) {
                [self hiddenFooter:YES];
            } else {
                [self hiddenFooter:NO];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KMessageTableViewCell];
    if (_viewType == MessagePrivate) {
        [cell loadPrivateData:_dataArray[_dataArray.count - indexPath.row - 1]];
    } else if (_viewType == MessagePublic) {
        [cell loadPublicData:_dataArray[_dataArray.count - indexPath.row - 1]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRow:indexPath];
    }
}

- (void)deleteRow:(NSIndexPath *)indexPath {
    [Utility showHUDWithTitle:@"正在删除"];
    if (_viewType == MessagePrivate) {
        [CommunicationrManager delMessage:@"0" orConversation:[_dataArray[indexPath.row] toId] ofType:MessagePrivate completion:^(NSString *message) {
            [Utility hiddenProgressHUD];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                [_dataArray removeObjectAtIndex:indexPath.row];
                [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager delMessage:[_dataArray[indexPath.row] pmId] orConversation:@"0" ofType:MessagePublic completion:^(NSString *message) {
            [Utility hiddenProgressHUD];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                [_dataArray removeObjectAtIndex:indexPath.row];
                [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic;
    if (_viewType == MessagePrivate) {
        dic = @{@"messageViewType":[NSNumber numberWithInt:_viewType], @"detailId":[_dataArray[_dataArray.count - indexPath.row - 1] toId], @"detailName":[_dataArray[_dataArray.count - indexPath.row - 1] toName]};
    } else if (_viewType == MessagePublic) {
        NSString *detailName;
        if ([_dataArray[_dataArray.count - indexPath.row - 1] authorName] == nil) {
            detailName = @"系统";
        } else {
            detailName = [_dataArray[_dataArray.count - indexPath.row - 1] authorName];
        }
        dic = @{@"messageViewType":[NSNumber numberWithInt:_viewType], @"detailId":[_dataArray[_dataArray.count - indexPath.row - 1] pmId], @"detailName":detailName};
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ToMessageDetail object:nil userInfo:dic];
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
