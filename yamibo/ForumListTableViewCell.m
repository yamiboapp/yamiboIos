//
//  ForumListTableViewCell.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ForumListTableViewCell.h"
#import "ForumModel.h"
@interface ForumListTableViewCell()

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *nameLabelContainer;
@property (strong, nonatomic) UIImageView *topicImgView;
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
    [self initView];
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
- (void)initView {
    _nameLabelContainer = [[UIView alloc] init];
    [_backView addSubview:_nameLabelContainer];
    
    _topicImgView = [[UIImageView alloc] init];
    UIImage *topicImg = [UIImage imageNamed:@"forum-topic"];
    [_topicImgView setImage:topicImg];
    [_nameLabelContainer addSubview:_topicImgView];

    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = KFONT(15);
    _nameLabel.textColor = KCOLOR_RED_6D2C1D;
    [_nameLabelContainer addSubview:_nameLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = KFONT(13);
    _titleLabel.textColor = KCOLOR_GRAY;
    [_backView addSubview:_titleLabel];
    
    UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
    [rightArrowImgView setImage:[UIImage imageNamed:@"arrow-right"]];
    self.accessoryView = rightArrowImgView;
    
    // constrains
    
    [_nameLabelContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-50);
        make.top.equalTo(self).offset(20);
    }];
    
    [_topicImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(_nameLabelContainer);
        make.width.mas_equalTo(topicImg.size.width);
        make.height.mas_equalTo(topicImg.size.height);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topicImgView.mas_right).offset(5);
        make.right.top.bottom.equalTo(_nameLabelContainer);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabelContainer);
        make.top.equalTo(_nameLabelContainer.mas_bottom).offset(10);
    }];
}

- (void)loadData:(ForumModel *)data {
    _nameLabel.text = [NSString stringWithFormat:@"%@（%@）", data.forumName, data.todayPosts];
    _titleLabel.text = data.content;
    
    // if title is empty, put name label at center vertically
    if (data.content == nil) {
        [_nameLabelContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(24);
            make.right.equalTo(self).offset(-50);
            make.centerY.equalTo(self);
        }];
        [_titleLabel removeFromSuperview];
    }
}

@end
