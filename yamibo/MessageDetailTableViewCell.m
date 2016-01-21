//
//  MessageDetailTableViewCell.m
//  yamibo
//
//  Created by shuang yang on 10/15/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageDetailTableViewCell.h"
#import "YFaceImageView.h"
#import "MessageModel.h"

@interface MessageDetailTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) YFaceImageView *headImg;
@property (strong, nonatomic) UILabel *timeLable;
@end
@implementation MessageDetailTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Fix the bug in iOS7 - initial constraints warning
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([reuseIdentifier  isEqual: KMessageDetailTableViewCell_In]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            [self configCell];
            [self initView];
            [self setupConstrainsIn];
        }
    } else {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            [self configCell];
            [self initView];
            [self setupConstrainsOut];
        }
    }

    return self;
}
- (void)configCell {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)initView {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [self.contentView addSubview:_backView];
    
    _contentLabel = [[YPostContentView alloc] init];
    //_contentLabel.numberOfLines = 0;
    //_contentLabel.font = KFONT(12);
    //_contentLabel.textColor = KCOLOR_GRAY;
    [_backView addSubview:_contentLabel];
    
    _headImg = [[YFaceImageView alloc] init];
    [_backView addSubview:_headImg];
    
    _timeLable = [[UILabel alloc] init];
    _timeLable.font = KFONT(10);
    _timeLable.textColor = KCOLOR_GRAY;
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.numberOfLines = 2;
    [_backView addSubview:_timeLable];
}

- (void)setupConstrainsIn {
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];

    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).offset(24);
        make.top.equalTo(_backView).offset(15);
        make.width.height.mas_equalTo(50);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(20);
        make.top.equalTo(_headImg);
        make.bottom.equalTo(_backView).offset(-15);
        make.width.mas_equalTo(190);
        //make.height.mas_greaterThanOrEqualTo(50);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.top.equalTo(_backView.mas_top).offset(15);
        make.right.equalTo(_backView.mas_right).offset(-24);
    }];
}

- (void)setupConstrainsOut {
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-24);
        make.top.equalTo(_backView).offset(15);
        make.width.height.mas_equalTo(50);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headImg.mas_left).offset(-20);
        make.top.equalTo(_headImg);
        make.bottom.equalTo(_backView).offset(-15);
        make.width.mas_equalTo(190);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.top.equalTo(_backView).offset(15);
        make.left.equalTo(_backView).offset(24);
    }];
}

- (void)loadPrivateData:(PrivateMessageDetailModel *)data {
    /*if ([data.pmId intValue]== 493323) {
        int y=1;
    }*/
    [_headImg setUserId:data.fromId andType:FaceMiddle];
 //   _contentLabel.text = data.message;
    //[_contentLabel setContentHtml:data.message];
    _timeLable.text = data.date;
    _pmid = [data.pmId intValue];
}

- (void)loadPublicData:(PublicMessageDetailModel *)data {
    [_headImg setUserId:data.authorId andType:FaceMiddle];
 //   _contentLabel.text = data.message;
    _timeLable.text = data.date;
}
- (CGFloat)getHeight {
    if (_height == 0) {
        CGFloat x = [_contentLabel.attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:190].height;
        if (x > 51) {
            _height = x + 30;
        } else {
            _height = 81;
        }
    }
    return _height;
}
/*- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.frame.size.width, [self getHeight]);
}*/
- (void)cellBgColor:(BOOL)longPressed {
    if (longPressed) {
        _backView.backgroundColor = KCOLOR_GRAY_70;
    } else {
        _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    }
}
@end
