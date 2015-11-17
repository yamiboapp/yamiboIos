//
//  LoginController.m
//  yamibo
//
//  Created by 李思良 on 15/9/26.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "LoginController.h"
#import "CommunicationrManager.h"
#import "MenuController.h"

@interface LoginController ()<UITextFieldDelegate, UIActionSheetDelegate>
@property   (strong, nonatomic) UIImageView *logo;

@property   (strong, nonatomic) UIView *containerView;

@property   (strong, nonatomic) UIView *backView;
@property   (strong, nonatomic) UITextField *nameField;
@property   (strong, nonatomic) UITextField *pwdField;
@property   (strong, nonatomic) UITextField *questionField;
@property   (strong, nonatomic) UITextField *answerField;

@property   (assign, nonatomic) int selectedQuestion;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
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
    _selectedQuestion = 0;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    [self showCustomNavigationButtonWithTitle:@"注册"];
    self.title = @"登陆";
}
- (void)initView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
    
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_containerView];
    
    [self initLogo];
    [self initFields];
    [self initConfirm];
}

- (void)initLogo {
    int logoSize = SCALE_NUM(112);
    _logo = [[UIImageView alloc] init];
    [_containerView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(27);
        make.width.height.mas_equalTo(logoSize);
    }];
    [_logo setImage:[UIImage imageNamed:@"ico-logo"]];
    _logo.layer.cornerRadius = logoSize / 2;
    _logo.clipsToBounds = true;
}

- (void)initFields {
    _backView = [[UIView alloc] init];
    [_containerView addSubview:_backView];
    _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_logo.mas_bottom).offset(15);
        make.height.mas_equalTo(SCALE_NUM(195));
    }];
    
    _nameField = [self configField:0];
    _pwdField = [self configField:1];
    _pwdField.secureTextEntry = true;
    _questionField = [self configField:2];
    _answerField = [self configField:3];
    
#if DEBUG
    _nameField.text = @"peps";
    _pwdField.text = @"19921030";
#endif
    
}

- (void)initConfirm {
    UIButton *btn = [[UIButton alloc] init];
    [_containerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCALE_NUM(266));
        make.centerX.equalTo(_backView);
        make.height.mas_equalTo(SCALE_NUM(44));
    }];
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = true;
    [btn setBackgroundImage:[UIImage imageWithColor:KCOLOR_RED_6D2C1D] forState:UIControlStateNormal];
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submit {
    [self.view endEditing:true];
    if (_nameField.text.length == 0) {
        [Utility showTitle:@"请填写用户名"];
        return;
    }
    if (_pwdField.text.length == 0) {
        [Utility showTitle:@"请填写密码"];
        return;
    }
    if (_selectedQuestion != 0 && _answerField.text.length == 0) {
        [Utility showTitle:@"请填写安全问题"];
        return;
    }
    [Utility showHUDWithTitle:@"正在登录..."];
    [CommunicationrManager loginWithName:_nameField.text andPwd:_pwdField.text andQuestion:[NSString stringWithFormat:@"%d", _selectedQuestion] andAnswer:_answerField.text completion:^(NSString *message) {
        [CommunicationrManager getProfile:^(NSString *message) {
            
        }];
        [Utility hiddenProgressHUD];
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            NSDictionary *dic = @{kLeftDrawerSelectionIndexKey:@(CenterControllerHome)};
            [[NSNotificationCenter defaultCenter] postNotificationName:KChangeCenterViewNotification object:nil userInfo:dic];
        }
    }];
}

- (UITextField *)configField:(int)index {
    NSArray *names = @[@"用户名", @"密码", @"安全提问(未设置请忽略)", @"安全提问答案"];
    UITextField *field = [[UITextField alloc] init];
    [_backView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(_backView).offset(index * SCALE_NUM(195)/4);
        make.height.equalTo(_backView).multipliedBy(0.25);
        make.centerX.equalTo(_backView);
    }];
    field.placeholder = names[index];
    field.font = KFONT(14);
    field.delegate = self;
    
    if (index != 3) {
        UIView *line = [[UIView alloc] init];
        [field addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(field);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    }
    
    field.returnKeyType = UIReturnKeyDone;
    
    return field;
}

- (void)showActionSheete {
    NSArray *questions = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SafeQuestion" ofType:@"plist"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < questions.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:questions[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _selectedQuestion = i;
            if (i == 0) {
                _questionField.text = nil;
            } else {
                _questionField.text = action.title;
            }
        }];
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:true completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_questionField]) {
        [self.view endEditing:true];
        [self showActionSheete];
        return false;
    }
    return true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    float offset = _backView.bottom + height - self.view.height;
    if (offset >= 0) {
        _containerView.top = -offset;
    }
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    _containerView.top = 0;
}
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
@end
