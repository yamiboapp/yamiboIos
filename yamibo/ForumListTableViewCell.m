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
    UIImageView *topicImgView = [[UIImageView alloc] init];
    UIImage *topicImg = [UIImage imageNamed:@"forum-topic"];
    [topicImgView setImage:topicImg];
    [_backView addSubview:topicImgView];
    [topicImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(24);
        make.width.mas_equalTo(topicImg.size.width);
        make.height.mas_equalTo(topicImg.size.height);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    [_backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topicImgView.mas_right).offset(5);
        make.top.bottom.equalTo(topicImgView);
    }];
    _nameLabel.font = KFONT(14);
    _nameLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _titleLabel = [[UILabel alloc] init];
    [_backView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topicImgView);
        make.top.equalTo(topicImgView.mas_bottom).offset(10);
    }];
    _titleLabel.font = KFONT(12);
    _titleLabel.textColor = KCOLOR_GRAY;
    
    UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
    [rightArrowImgView setImage:[UIImage imageNamed:@"arrow-right"]];
    self.accessoryView = rightArrowImgView;
    
    /*UIImageView *rightArrowImgView = [[UIImageView alloc] init];
    [_backView addSubview:rightArrowImgView];
    [rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-22);
        make.centerY.equalTo(_titleLabel);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    rightArrowImgView.backgroundColor = [UIColor redColor];*/
}
- (void)loadData:(ForumModel *)data {
    _nameLabel.text = [NSString stringWithFormat:@"%@（%@）", data.forumName, data.todayPosts];
    _titleLabel.text = data.content;
}

@end
