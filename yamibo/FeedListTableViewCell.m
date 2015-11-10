


//
//  FeedListTableViewCell.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "FeedListTableViewCell.h"
#import "YFaceImageView.h"
#import "HotModel.h"

@interface FeedListTableViewCell()
@property (strong, nonatomic) YFaceImageView *headImg;
@property (strong, nonatomic) UILabel   *nameLabel;
@property (strong, nonatomic) UILabel   *timeLabel;
@property (strong, nonatomic) UILabel   *titleLabel;
@property (strong, nonatomic) UILabel   *commentLabel;
@property (strong, nonatomic) UILabel   *watchLabel;

@property (assign, nonatomic) BOOL      isNoPicMode;

@property (strong, nonatomic) UIView    *backView;

@end

@implementation FeedListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _isNoPicMode = [reuseIdentifier isEqualToString:KNoImgFeedListTableViewCell];
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
        if (_isNoPicMode) {
            make.height.mas_equalTo(74);
        } else {
            make.height.mas_equalTo(74);
        }
    }];
}
- (void)initViews {
    _titleLabel = [[UILabel alloc] init];
    [_backView addSubview:_titleLabel];
    _titleLabel.font = KFONT(15);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _nameLabel = [[UILabel alloc] init];
    [_backView addSubview:_nameLabel];
    _nameLabel.font = KFONT(10);
    
    _timeLabel = [[UILabel alloc] init];
    [_backView addSubview:_timeLabel];
    _timeLabel.font = KFONT(9);
    _timeLabel.textColor = KCOLOR_GRAY;
    
    if (_isNoPicMode) {
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(12);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom).offset(15);
        }];
        _nameLabel.textColor = KCOLOR_GRAY;
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right).offset(15);
            make.top.equalTo(_nameLabel);
        }];
        
    } else {
        _headImg = [[YFaceImageView alloc] init];
        [_backView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(12);
        }];
        _headImg.layer.cornerRadius = 2;
        _headImg.clipsToBounds = true;
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImg.mas_right).offset(6);
            make.top.equalTo(_headImg);
        }];
        _nameLabel.textColor = KCOLOR_RED_6D2C1D;

        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(4);
        }];

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImg);
            make.top.equalTo(_headImg.mas_bottom).offset(6);
            make.centerX.equalTo(_backView);
        }];
    }
    [self initRightInfo];
}
- (void)initRightInfo {
    UIView *info = [[UIView alloc] init];
    [_backView addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-20);
        make.height.mas_equalTo(9);
        make.centerY.equalTo(_nameLabel);
    }];
    
    _watchLabel = [[UILabel alloc] init];
    [info addSubview:_watchLabel];
    [_watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(info);
    }];
    _watchLabel.font = KFONT(9);
    _watchLabel.textColor = KCOLOR_GRAY;
    

    
    UIImageView *watchImgView = [[UIImageView alloc] init];
    UIImage *watchImg = [UIImage imageNamed:@"forum-view"];
    [watchImgView setImage:watchImg];
    [info addSubview:watchImgView];
    [watchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(info);
        make.width.mas_equalTo(watchImg.size.width);
        make.height.mas_equalTo(watchImg.size.height);
        make.right.equalTo(_watchLabel.mas_left).offset(-2);
    }];
    
    _commentLabel = [[UILabel alloc] init];
    [info addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(watchImgView.mas_left).offset(-5);
        make.top.bottom.equalTo(info);
    }];
    _commentLabel.font = KFONT(9);
    _commentLabel.textColor = KCOLOR_GRAY;
    
    UIImageView *commentImgView = [[UIImageView alloc] init];
    UIImage *commentImg = [UIImage imageNamed:@"forum-comment"];
    [commentImgView setImage:commentImg];
    [info addSubview:commentImgView];
    [commentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(info);
        make.width.mas_equalTo(commentImg.size.width);
        make.height.mas_equalTo(commentImg.size.height);
        make.right.equalTo(_commentLabel.mas_left).offset(-2);
    }];
    
}
- (void)loadData:(DataImg *)data {
    if (_isNoPicMode) {
        
    } else {
        [_headImg setUserId:data.authorId andType:FaceMiddle];
    }
    _nameLabel.text = data.authorName;
    _timeLabel.text = [NSString stringWithFormat:@"最新回复：%@",data.lastPost];
    _titleLabel.text = [data.title stringFromHTML];
    _commentLabel.text = data.replyNum;
    _watchLabel.text = data.viewNum;
}
@end
