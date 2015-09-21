//
//  MessageSwitchView.m
//  yamibo
//
//  Created by 李思良 on 15/9/21.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "MessageSwitchView.h"

@interface MessageSwitchView()
@property (strong, nonatomic) UIView *line;
@end

@implementation MessageSwitchView

- (instancetype)initWithItems:(NSArray *)names {
    if (self = [super init]) {
        UILabel *label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return self;
}

@end
