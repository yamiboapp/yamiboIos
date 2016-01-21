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

@interface MessageDetailTableView()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, atomic) NSMutableArray *cellFlagArray;
@property (strong, atomic) NSMutableArray *heightArray;
@property (strong, atomic) NSMutableDictionary *pmidIndexDic;

//@property (strong, atomic) NSMutableArray *cellArray;

@property (assign, nonatomic) MessageViewType viewType;
@property (assign, nonatomic) NSInteger detailId;
@property (assign, nonatomic) int msgCount;
@property (assign, nonatomic) int perPage;
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
        _cellFlagArray = [NSMutableArray array];
        //_cellArray = [NSMutableArray array];
        _heightArray = [NSMutableArray array];
        _pmidIndexDic = [NSMutableDictionary dictionary];

        [self registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:KMessageDetailTableViewCell_In];
        [self registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:KMessageDetailTableViewCell_Out];
        self.estimatedRowHeight = 200;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peps:) name:@"peps" object:nil];
    }
    return self;
}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    __unsafe_unretained MessageDetailTableView *weakSelf = self;
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageDetailList:1 toId:_detailId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            [weakSelf stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
                
            } else {
                _dataArray = [NSMutableArray arrayWithArray:[[model.msgList reverseObjectEnumerator] allObjects]];
                //_cellArray = [NSMutableArray array];
                for (int i = 0; i < model.msgList.count; ++i) {
                    [_heightArray addObject:@81];
                }
                //_cellFlagArray = [NSMutableArray array];
                for (int i = 0; i < _dataArray.count; ++i) {
                    [_cellFlagArray addObject:@0];
                    PrivateMessageDetailModel *data = [_dataArray objectAtIndex:i];
                    [_pmidIndexDic setObject:[NSNumber numberWithInt:i] forKey:data.pmId];
                }

                _msgCount = [model.count intValue];
                _perPage = [model.perPage intValue];
                //FIXME: 所有类似tableview都需注意_msgCount == _perPage的情况
                if (model.msgList.count < _perPage || _msgCount == _perPage) {
                    [weakSelf hiddenHeader:YES];
                } else {
                    [weakSelf hiddenHeader:NO];
                }
                [weakSelf reloadData];
            }
        }];
    } else if (_viewType == MessagePublic) {
        [CommunicationrManager getPublicMessageDetailList:_detailId completion:^(PublicMessageDetailListModel *model, NSString *message) {
            [weakSelf stopLoadNewData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                _dataArray = [NSMutableArray arrayWithArray:model.msgList];
                [weakSelf hiddenHeader:YES];
                [weakSelf reloadData];
            }
        }];
    }
    [self hiddenFooter:YES];
}
- (void)loadMoreData {
    __unsafe_unretained MessageDetailTableView *weakSelf = self;
    if (_viewType == MessagePrivate) {
        [CommunicationrManager getPrivateMessageDetailList:(int)_dataArray.count / _perPage + 1 toId:_detailId completion:^(PrivateMessageDetailListModel *model, NSString *message) {
            [weakSelf stopLoadMoreData];
            if (message != nil) {
                [Utility showTitle:message];
            } else {
                //从后往前加载
                [_dataArray replaceObjectsInRange:NSMakeRange(0,0)
                                withObjectsFromArray:[[model.msgList reverseObjectEnumerator] allObjects]];
                for (int i = 0; i < model.msgList.count; ++i) {
                    [_heightArray insertObject:@81 atIndex:0];
                    //[_cellArray insertObject:[[MessageDetailTableViewCell alloc] init] atIndex:0];
                }
                _cellFlagArray = [NSMutableArray array];
                for (int i = 0; i < _dataArray.count; ++i) {
                    [_cellFlagArray addObject:@0];
                    PrivateMessageDetailModel *data = [_dataArray objectAtIndex:i];
                    [_pmidIndexDic setObject:[NSNumber numberWithInt:i]  forKey:data.pmId];
                }
            }
            if (model.msgList.count < _perPage) {
                [weakSelf hiddenHeader:YES];
            } else {
                [weakSelf hiddenHeader:NO];
            }
            [weakSelf reloadData];
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
- (void)peps:(NSNotification*)notification {
    
    NSDictionary *dic = notification.userInfo;
    CGFloat height = [dic[@"height"] floatValue] + 30;
    long index = [[_pmidIndexDic objectForKey:[(NSNumber*)dic[@"pmid"] stringValue]] intValue];
    
    //MessageDetailTableViewCell *cell = (MessageDetailTableViewCell *)[self viewWithTag:pmid];
    if (height != [[_heightArray objectAtIndex:index] floatValue] && height > 81) {
        [_heightArray replaceObjectAtIndex:index withObject:[NSNumber numberWithFloat:height]];
        //[self beginUpdates];
        //[self endUpdates];
    }

}
- (void)configureCell:(MessageDetailTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    long x = indexPath.row;
    switch (x) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            break;
        case 10:
            break;
        case 11:
            break;
        default:
            break;
    }
    PrivateMessageDetailModel *model = _dataArray[indexPath.row];

    //MessageDetailTableViewCell *c = [_cellArray objectAtIndex:indexPath.row];
    //if ([cell isEqual:c]) {
     //   cell.contentLabel = c.contentLabel;
    //} else {
        [cell.contentLabel setContentHtml:model.message];
    //}
    if (_viewType == MessagePrivate) {
        [cell loadPrivateData:_dataArray[indexPath.row]];
    } else if (_viewType == MessagePublic) {
        [cell loadPublicData:_dataArray[indexPath.row]];
    }
    cell.tag = cell.pmid;
    cell.contentLabel.tag = cell.pmid;
    UILongPressGestureRecognizer *msgLPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mMsgLongPress:)];
    [msgLPGR setNumberOfTouchesRequired:1];
    [msgLPGR setAllowableMovement:100];
    [msgLPGR setMinimumPressDuration:0.5];
    //[cell addGestureRecognizer:msgLPGR];

    //if (![_cellArray containsObject:cell]) {
    //[_cellArray replaceObjectAtIndex:indexPath.row withObject:cell];
    //}
    /*if (![_cellArray containsObject:cell]) {
        [_cellArray insertObject:cell atIndex:indexPath.row];
    }*/
    //[_pmidIndexDic setObject:[NSNumber numberWithInt:cell.pmid] forKey:[NSNumber numberWithInteger:indexPath.row]];
    CGFloat height = cell.contentLabel.displayHeight + 30;
    if (height > 81) {
        [_heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
    }
    [_cellFlagArray replaceObjectAtIndex:indexPath.row withObject:@1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    MessageDetailTableViewCell *cell;
    if (_viewType == MessagePublic || data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_In forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:KMessageDetailTableViewCell_Out forIndexPath:indexPath];
    }
    NSLog([NSString stringWithFormat:@"A: %ld %d", (long)indexPath.row, cell.pmid]);
    //if ([[_cellFlagArray objectAtIndex:indexPath.row] isEqualToValue:@0]) {
        [self configureCell:cell atIndexPath:indexPath];
        NSLog([NSString stringWithFormat:@"B: %ld %d", (long)indexPath.row, cell.pmid]);
    //}
    
    //NSLog([NSString stringWithFormat:@"B: %ld %d", (long)indexPath.row, cell.pmid]);

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if ([(NSNumber*)_cellFlagArray[indexPath.row] isEqualToValue:@0]) {
        return 81;
    }*/
    long x = indexPath.row;

    //MessageDetailTableViewCell *cell = [_cellArray objectAtIndex:indexPath.row];
    //return cell.height;
    //return [[_cellFlagArray objectAtIndex:indexPath.row] floatValue];
    /*CGFloat height = cell.contentLabel.displayHeight + 30;
    if (height > 81) {
        [_heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
    }*/
    return [_heightArray[indexPath.row] floatValue];
    /*PrivateMessageDetailModel *data = _dataArray[indexPath.row];
    if (_viewType == MessagePublic || data.toId == [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]) {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_In cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:KMessageDetailTableViewCell_Out cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }*/
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
    __unsafe_unretained MessageDetailTableView *weakSelf = self;
    [CommunicationrManager delMessage:[_dataArray[indexPath.row] pmId] orConversation:@"0" ofType:_viewType completion:^(NSString *message) {
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
