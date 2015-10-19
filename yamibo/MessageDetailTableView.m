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
@property (assign, nonatomic) NSInteger detailId;
@property (assign, nonatomic) float msgCount;
@property (assign, nonatomic) float perPage;
@property (assign, nonatomic) int currentPage;
@property (strong, nonatomic) UIView *editingMenuView;              //click cell to open the option panel
@property (strong, nonatomic) MessageDetailTableViewCell *longPressedCell;
@end

@implementation MessageDetailTableView
- (instancetype)init
{
    return [self initWithViewType:MessagePrivate andDetailId:0];
}
- (instancetype)initWithViewType:(MessageViewType)type andDetailId:(NSInteger)detailId{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        _viewType = type;
        _detailId = detailId;
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
        [CommunicationrManager getPrivateMessageDetailList:1 toId:_detailId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            [self stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _msgCount = [model.count intValue];
                _perPage = [model.perPage intValue];
                _currentPage = ceil(_msgCount / _perPage);
                [CommunicationrManager getPrivateMessageDetailList:_currentPage toId:_detailId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
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
        [CommunicationrManager getPublicMessageDetailList:_detailId completion:^(PublicMessageDetailListModel *model, NSString *message) {
            [self stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _dataArray = [NSMutableArray arrayWithArray:model.msgList];
                [self hiddenFooter:true];
                [self reloadData];
            }
        }];
    }
    
}
- (void)loadMoreData {
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageDetailList:--_currentPage toId:_detailId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            [self stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                //从后往前加载
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
    UILongPressGestureRecognizer *msgLPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mMsgLongPress:)];
    [msgLPGR setNumberOfTouchesRequired:1];
    [msgLPGR setAllowableMovement:100];
    [msgLPGR setMinimumPressDuration:0.5];
    [cell addGestureRecognizer:msgLPGR];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    MessageDetailTableViewCell *cell;

    if (_viewType == MessagePublic || data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_In];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_Out];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    if (_viewType == MessagePublic || data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_In cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_Out cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


#pragma mark popup option view
-(void)mMsgLongPress:(UILongPressGestureRecognizer *)recognizer{
    
    CGPoint touchP = [recognizer locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:touchP];
    _longPressedCell = [self cellForRowAtIndexPath:indexPath];

    
    if (indexPath != nil) {
        [_longPressedCell cellBgColor:YES];

        if (recognizer.state == UIGestureRecognizerStateBegan) {
            if (!_editingMenuView) {
                [self initEditingMenuView];
            } else {
                [_editingMenuView setHidden:NO];
                _editingMenuView.alpha = 0;
            }
            
            [_editingMenuView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(_longPressedCell);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(40);
            }];
            
            [UIView animateWithDuration:0.3 animations:^{
                _editingMenuView.alpha = 1;
            } completion:nil];
        }
    }
}
-(void)initEditingMenuView {
    _editingMenuView = [[UIView alloc] init];
    _editingMenuView.alpha = 0;
    [self addSubview:_editingMenuView];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.backgroundColor = KCOLOR_RED_FC481F;
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];

    [deleteBtn addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchDown];
    [deleteBtn addTarget:self action:@selector(deleteBtnDepressed) forControlEvents:UIControlEventTouchUpInside];

    [_editingMenuView addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_editingMenuView);
    }];
}
- (void)deleteRow:(NSIndexPath *)indexPath {
    [Utility showHUDWithTitle:@"正在删除"];
    [CommunicationrManager delMessage:[_dataArray[indexPath.row] pmId] orConversation:@"" ofType:_viewType completion:^(NSString *message) {
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    [Utility hiddenProgressHUD];

}
-(void)deleteBtnPressed {
}
-(void)deleteBtnDepressed {
    [_editingMenuView setHidden:YES];
    NSIndexPath *indexPath = [self indexPathForCell:_longPressedCell];
    [self deleteRow:indexPath];
}
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    id hitView = [super hitTest:point withEvent:event];
    CGRect rect = _editingMenuView.frame;
    if (!CGRectContainsPoint(rect, point)) {
        [_longPressedCell cellBgColor:NO];
        [_editingMenuView setHidden:YES];
    }
    return hitView;
}

#pragma mark inheritance

- (BOOL)showHeaderRefresh
{
    return YES;
}
- (BOOL)showFooterRefresh
{
    return YES;
}

@end
