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
#import "MessageModel.h"

@interface MessageTableView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) MessageViewType viewType;
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
            }
            if (model.msgList.count < 20) {
                [self hiddenFooter:true];
            } else {
                [self hiddenFooter:false];
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
        [CommunicationrManager getPrivateMessageList:(int)_dataArray.count / 20 + 1 completion:^(PrivateMessageListModel *model, NSString *message) {
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
#pragma tableview datasource
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
        [cell loadPrivateData:_dataArray[indexPath.row]];
    } else if (_viewType == MessagePublic) {
        [cell loadPublicData:_dataArray[indexPath.row]];
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
    [CommunicationrManager delMessage:[_dataArray[indexPath.row] pmId] completion:^(NSString *message) {
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
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
