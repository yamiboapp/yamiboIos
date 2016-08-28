//
//  NeighborTableViewCell.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "NeighborTableViewCell.h"
#import "YFaceImageView.h"
@interface NeighborTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) YFaceImageView *headImg;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UIImageView *genderTint;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation NeighborTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        [self initBack];
        [self initView];
    }
    return self;
}
- (void)configCell {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)initBack {
    _backView = [[UIView alloc] init];
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
    }];
    _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
}

- (void)initView {
    _headImg = [[YFaceImageView alloc] init];
    [_backView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.width.height.mas_equalTo(48);
        make.centerY.equalTo(_backView);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    [_backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(6);
        make.top.equalTo(_headImg).offset(8);
    }];
    _nameLabel.font = KFONT(14);
    _nameLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _distanceLabel = [[UILabel alloc] init];
    [_backView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.bottom.equalTo(_headImg).offset(-6);
    }];
    _distanceLabel.font = KFONT(11);
    _distanceLabel.textColor = KCOLOR_GRAY;
    
    _genderTint = [[UIImageView alloc] init];
    [_backView addSubview:_genderTint];
    [_genderTint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(8);
        make.centerY.equalTo(_nameLabel);
        make.width.height.mas_equalTo(14);
    }];
    _genderTint.backgroundColor = [UIColor redColor];
    
    _contentLabel = [[UILabel alloc] init];
    [_backView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(self);
        make.top.equalTo(_headImg);
    }];
    _contentLabel.font = KFONT(11);
    _contentLabel.textColor = KCOLOR_GRAY;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 5;
}

- (void)loadData {
    [_headImg setUserId:@"123456"];
    _nameLabel.text = @"南ことり";
    _distanceLabel.text = @"200米以内";
    _contentLabel.text = @"这个人是很懒，并没有留下什么这个人是很懒，并没有留下什么这个人是很懒，并没有留下什么";
}

@end
