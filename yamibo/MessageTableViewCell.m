//
//  MessageTableViewCell.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "YFaceImageView.h"

@interface MessageTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) YFaceImageView *headImg;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLable;

@end

@implementation MessageTableViewCell

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
    
    _titleLabel = [[UILabel alloc] init];
    [_backView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(20);
        make.top.equalTo(_headImg).offset(1);
    }];
    _titleLabel.font = KFONT(13);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _contentLabel = [[UILabel alloc] init];
    [_backView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(_headImg).offset(-10);
    }];
    _contentLabel.font = KFONT(11);
    _contentLabel.textColor = KCOLOR_GRAY;
    
    
    _timeLable = [[UILabel alloc] init];
    [_backView addSubview:_timeLable];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-35);
        make.width.mas_equalTo(40);
        make.top.equalTo(_headImg).offset(3);
    }];
    _timeLable.font = KFONT(10);
    _timeLable.textColor = KCOLOR_GRAY;
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.numberOfLines = 5;
}

- (void)loadData {
//    [_headImg setUserId:@"233" pic:@"http://www.ineeyou.com/data/attachment/forum/201501/31/145145ihi6nj42hhz4f4qs.png"];
    _titleLabel.text = @"我对你说:";
    _contentLabel.text = @"约吗";
    _timeLable.text = @"4-22 12:00";
}

@end
