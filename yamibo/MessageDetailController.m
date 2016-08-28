//
//  MessageDetailController.m
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageDetailController.h"
#import "MessageDetailTableView.h"
#import "InputBoxView.h"
#import "CommunicationrManager.h"
#import "ActionResponseModel.h"

@interface MessageDetailController ()<UITextViewDelegate>

@property (assign, nonatomic) MessageViewType viewType;
@property (assign, nonatomic) NSInteger detailId; //toUid
@property (assign, nonatomic) NSString *detailName;

@property (strong, nonatomic) MessageDetailTableView *tableView; // message list
@property (strong, nonatomic) InputBoxView *inputBox; // message send box
@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
    
    // send message
    __weak __block MessageDetailController *copy_self = self;
    [self.inputBox setSendMessageBlock:^(NSString *content) {
        [copy_self sendMessage:content];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)configNavigation {
    [self showCustomNavigationBackButton];
    if (_viewType == MessagePrivate) {
        self.title = [NSString stringWithFormat:@"与 %@ 的对话", _detailName];
    } else if (_viewType == MessagePublic) {
        self.title = [NSString stringWithFormat:@"来自 %@ 的消息", _detailName];
    }
}
- (void)initView {
    _tableView = [[MessageDetailTableView alloc] initWithViewType:_viewType andDetailId:_detailId];
    [self.view addSubview:_tableView];

    _inputBox = [[InputBoxView alloc] init];
    [self.view addSubview:_inputBox];
    
    // constrains
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_inputBox.mas_top).offset(-2);
    }];
    [_inputBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
    }];
    
    [_tableView refreshData];
}

- (void)sendMessage:(NSString *)content {
    __weak __block MessageDetailController *copy_self = self;
    [CommunicationrManager sendMessage:content toUid:copy_self.detailId completion:^(ActionResponseModel *model, NSString *message) {
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            [Utility showTitle:model.response];
        }
    }];
}

- (void)loadData:(NSDictionary *)data {
    _viewType = [data[@"viewType"] intValue];
    _detailId = [data[@"detailId"] intValue];
    _detailName = data[@"detailName"];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    [_inputBox mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [_inputBox mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
}

@end