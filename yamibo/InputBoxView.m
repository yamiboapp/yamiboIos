//
//  ReplyView.m
//  yamibo
//
//  Created by shuang yang on 3/5/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "InputBoxView.h"
#import "YInputTextView.h"

@interface InputBoxView ()<UITextViewDelegate>

@property(strong, nonatomic) YInputTextView *inputTextView;
@property(strong, nonatomic) UIButton *addButton, *emotionButton, *sendButton;

@end

@implementation InputBoxView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    }
    [self initView];
    
    _inputTextView.delegate = self;
    
    [_emotionButton addTarget:self
                       action:@selector(tapFace:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [_sendButton addTarget:self
                    action:@selector(tapSend:)
          forControlEvents:UIControlEventTouchUpInside];

    return self;
}
- (void)initView {
    _inputTextView = [[YInputTextView alloc] init];
    _inputTextView.font = KFONT(15);
    _inputTextView.layer.cornerRadius = 4;
    _inputTextView.layer.borderWidth = 1;
    _inputTextView.layer.borderColor=[KCOLOR_GRAY CGColor];
    _inputTextView.clipsToBounds = true;
    [self addSubview:_inputTextView];
    
    _addButton = [[UIButton alloc] init];
    UIImage *addImage = [UIImage imageNamed:@"keyboard-add"];
    [_addButton setImage:addImage forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
    _emotionButton = [[UIButton alloc] init];
    UIImage *emotionImage = [UIImage imageNamed:@"keyboard-emotion"];
    [_emotionButton setImage:emotionImage forState:UIControlStateNormal];
    [self addSubview:_emotionButton];
    
    _sendButton = [[UIButton alloc] init];
    _sendButton.layer.cornerRadius = 4;
    _sendButton.clipsToBounds = true;
    _sendButton.backgroundColor = KCOLOR_RED_6D2C1D;
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self addSubview:_sendButton];

    // constrains
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(5);
        make.width.mas_equalTo(addImage.size.width);
        make.height.mas_equalTo(addImage.size.height);
    }];
    [_emotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addButton);
        make.left.equalTo(_addButton.mas_right).offset(5);
        make.width.mas_equalTo(emotionImage.size.width);
        make.height.mas_equalTo(emotionImage.size.height);
    }];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inputTextView);
        make.right.equalTo(self).offset(-5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7);
        make.left.equalTo(_emotionButton.mas_right).offset(5);
        make.right.equalTo(_sendButton.mas_left).offset(-5);
        make.bottom.equalTo(self).offset(-7);
        make.height.mas_equalTo(35);
    }];
}

//发送图文
- (NSString *)getInputText {
    //正则表达式取出表情
    NSString *str = _inputTextView.text;
    NSMutableAttributedString *strAtt =
    [[NSMutableAttributedString alloc] initWithString:str];
    //创建匹配正则表达式类型描述模板
    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //依据正则表达式创建匹配对象
    NSError *error = nil;
    // CaseInsensitive
    NSRegularExpression *regular = [NSRegularExpression
                                    regularExpressionWithPattern:pattern
                                    options:NSRegularExpressionCaseInsensitive
                                    error:&error];
    if (regular == nil) {
        NSLog(@"正则创建失败");
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    //把搜索出来的结果存到数组中
    NSArray *result =
    [regular matchesInString:strAtt.string
                     options:NSMatchingReportCompletion
                       range:NSMakeRange(0, strAtt.string.length)];
    
    NSString *path =
    [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSArray *arrPlist = [NSArray arrayWithContentsOfFile:path];
    
    for (NSInteger i = result.count - 1; i >= 0; i--) {
        NSTextCheckingResult *r = result[i];
        // NSLog(@"%@",NSStringFromRange(r.range));
        NSString *imageStr = [strAtt.string substringWithRange:r.range];
        // NSLog(@"%@",imageStr);
        
        for (NSDictionary *dic in arrPlist) {
            if ([dic[@"chs"] isEqualToString:imageStr]) {
                NSTextAttachment *textAtt = [[NSTextAttachment alloc] init];
                textAtt.image = [UIImage imageNamed:dic[@"png"]];
                NSAttributedString *strImage =
                [NSAttributedString attributedStringWithAttachment:textAtt];
                [strAtt replaceCharactersInRange:r.range withAttributedString:strImage];
            }
        }
    }
    return strAtt.string;
}

- (void)tapFace:(UIButton *)sender {
    //如果还没弹出键盘就直接弹出表情键盘；弹出了就改变键盘样式
    if (_inputTextView.isFirstResponder) {
        [_inputTextView changeKeyBoard];
    } else {
        [_inputTextView setFaceKeyBoard];
        [_inputTextView becomeFirstResponder];
    }
}

- (void)tapSend:(UIButton *)sender {
    self.sendMessageBlock([self getInputText]);
    _inputTextView.text = nil;
    [self endEditing:true];
}

#pragma mark UITextViewDelegate

/**
 *  @author Shuang Yang, 16-08-28
 *
 *  @brief Resize textView to fit its content
 *
 *  @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView {
    CGSize newSize = [textView sizeThatFits:CGSizeMake(textView.width, MAXFLOAT)];
    CGFloat newHeight = newSize.height;
    
    [_inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
}

@end