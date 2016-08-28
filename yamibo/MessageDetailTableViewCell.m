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

- (void)awakeFromNib {
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
    [_backView addSubview:_contentLabel];
    
    _headImg = [[YFaceImageView alloc] init];
    [_backView addSubview:_headImg];
    
    _timeLable = [[UILabel alloc] init];
    _timeLable.font = KFONT(11);
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
        make.right.equalTo(_backView).offset(-94);
        make.top.equalTo(_headImg);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);;
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
        make.bottom.equalTo(_backView).offset(-15);
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
        make.left.equalTo(_backView).offset(94);
        make.right.equalTo(_headImg.mas_left).offset(-20);
        make.top.equalTo(_headImg);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel);;
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
        make.bottom.equalTo(_backView).offset(-15);
    }];
}

- (void)loadPrivateData:(PrivateMessageDetailModel *)data {
    [_headImg setUserId:data.fromId andType:FaceMiddle];
    [_contentLabel setContentHtml:data.message];
    _timeLable.text = [data.date toLocalTime];
    _pmid = [data.pmId intValue];
    
}
- (void)loadPublicData:(PublicMessageDetailModel *)data {
    [_headImg setUserId:data.authorId andType:FaceMiddle];
    [_contentLabel setContentHtml:data.message];
    _timeLable.text = [data.date toLocalTime];
}

- (CGFloat)getHeight {
    CGFloat contentLabelWidth = self.contentView.frame.size.width - 188;
    CGFloat contentLabelHeight = [_contentLabel.attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:contentLabelWidth].height;
    if (contentLabelHeight > 95) {
        _height = contentLabelHeight + 55;
    } else {
        _height = 95;
    }
    return _height;
}

@end
