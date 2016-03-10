//
//  ReplyView.m
//  yamibo
//
//  Created by shuang yang on 3/5/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "YReplyView.h"

@implementation YReplyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    }
    [self initView];
    return self;
}
- (void)initView {
    UIButton *plusBtn = [[UIButton alloc] init];
    UIImage *plusImg = [UIImage imageNamed:@"btn-attachment"];
    [plusBtn setImage:plusImg forState:UIControlStateNormal];
    [self addSubview:plusBtn];
    
    UIButton *smileyBtn = [[UIButton alloc] init];
    UIImage *smileyImg = [UIImage imageNamed:@"btn-smiley"];
    [smileyBtn setImage:smileyImg forState:UIControlStateNormal];
    [self addSubview:smileyBtn];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(plusImg.size.width);
        make.height.mas_equalTo(plusImg.size.height);
    }];
    [smileyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plusBtn.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(smileyImg.size.width);
        make.height.mas_equalTo(smileyImg.size.height);
    }];
}

@end
