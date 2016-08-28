//
//  ReplyView.m
//  yamibo
//
//  Created by shuang yang on 3/5/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "YInputTextView.h"

@interface YInputTextView ()

@end

@implementation YInputTextView

- (instancetype)init {
    if (self = [super init]) {
        [self loadFaceKeyBoardView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self loadFaceKeyBoardView];
}

- (void)loadFaceKeyBoardView {
    self.viewFaceKB = [[YFaceKeyBoardView alloc] init];
    
    __weak __block YInputTextView *copy_self = self;
    
    [self.viewFaceKB
     setFaceKeyBoardBlock:^(NSString *faceName, NSInteger faceTag) {
         copy_self.text = [copy_self.text stringByAppendingString:faceName];
     }];
    
    [self.viewFaceKB setFaceKeyBoardSendBlock:^{
        copy_self.sendBlock();
        //清空textview
        copy_self.text = nil;
    }];
    [self.viewFaceKB setFaceKeyBoardDeleteBlock:^{
        NSMutableString *string =
        [[NSMutableString alloc] initWithString:copy_self.text];
        [string deleteCharactersInRange:NSMakeRange(copy_self.text.length - 1, 1)];
        copy_self.text = string;
    }];
}

- (void)changeKeyBoard {
    if (self.inputView != nil) {
        self.inputView = nil;
        [self reloadInputViews];
    } else {
        self.inputView = self.viewFaceKB;
        [self reloadInputViews];
    }
}

- (void)setFaceKeyBoard {
    self.inputView = self.viewFaceKB;
}

@end
