//
//  ForumListTableViewCell.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ForumListTableViewCell.h"

@interface ForumListTableViewCell()

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation ForumListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
    }
    return self;
}
- (void)initCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self initBackView];
    [self initViews];
}
- (void)initBackView {
    _backView = [[UIView alloc] init];
    [self addSubview:_backView];
    _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(77);
    }];
}
- (void)initViews {
    UIImageView *tint = [[UIImageView alloc] init];
    [_backView addSubview:tint];
    [tint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(24);
        make.width.height.mas_equalTo(15);
    }];
    tint.backgroundColor = [UIColor redColor];
    
    _nameLabel = [[UILabel alloc] init];
    [_backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tint.mas_right).offset(5);
        make.top.bottom.equalTo(tint);
    }];
    _nameLabel.font = KFONT(14);
    _nameLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _titleLabel = [[UILabel alloc] init];
    [_backView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tint);
        make.top.equalTo(tint.mas_bottom).offset(10);
    }];
    _titleLabel.font = KFONT(12);
    _titleLabel.textColor = KCOLOR_GRAY;
    
    
    UIImageView *rightArray = [[UIImageView alloc] init];
    [_backView addSubview:rightArray];
    [rightArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-22);
        make.centerY.equalTo(_titleLabel);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    rightArray.backgroundColor = [UIColor redColor];
}
- (void)loadData {
    _nameLabel.text = @"讨论区（23）";
    _titleLabel.text = @"介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍";
}

@end
