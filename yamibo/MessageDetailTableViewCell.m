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
@property (strong, nonatomic) UILabel *contentLabel;
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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        [self initView];
        [self setupConstrains];
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
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = KFONT(12);
    _contentLabel.textColor = KCOLOR_GRAY;
    [_backView addSubview:_contentLabel];
    
    _headImg = [[YFaceImageView alloc] init];
    [_backView addSubview:_headImg];
    
    _timeLable = [[UILabel alloc] init];
    _timeLable.font = KFONT(10);
    _timeLable.textColor = KCOLOR_GRAY;
    //_timeLable.textAlignment = NSTextAlignmentLeft;
    _timeLable.numberOfLines = 1;
    [_backView addSubview:_timeLable];
}

- (void)setupConstrains {
    
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
        make.right.equalTo(_backView).offset(-24);
        make.top.equalTo(_headImg);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentLabel.mas_right);
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
        make.bottom.equalTo(_backView.mas_bottom).offset(-15);
    }];
    [_backView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                   forAxis:UILayoutConstraintAxisVertical];
    
    [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                             forAxis:UILayoutConstraintAxisVertical];
    
}

- (void)loadPrivateData:(PrivateMessageDetailModel *)data {
    [_headImg setUserId:data.fromId andType:FaceMiddle];
    _contentLabel.text = data.message;
    _timeLable.text = @"2012-2-23 18:33";
    _timeLable.text = data.date;
}

- (void)loadPublicData:(PublicMessageModel *)data {
    [_headImg setUserId:data.authorId andType:FaceMiddle];
    _contentLabel.text = data.summary;
    _timeLable.text = @"2012-2-23 18:33";
    //_timeLable.text = data.date;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [_contentLabel sizeThatFits:size].height;
    totalHeight += [_timeLable sizeThatFits:size].height;
    totalHeight += 60; // margins
    totalHeight = MAX(totalHeight, 79);
    return CGSizeMake(size.width, totalHeight);
}
@end
