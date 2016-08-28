//
//  ArticleListTableViewCell.m
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleListTableViewCell.h"
#import "ArticleModel.h"
#import "DTCoreText/DTCoreText.h"

@interface ArticleListTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *lastPostDateLabel;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UILabel *watchLabel;
@property (strong, nonnull) UIImageView *digestImgView;
@end

@implementation ArticleListTableViewCell
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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = KFONT(15);
    _titleLabel.textColor =  KCOLOR_RED_6D2C1D;
    _titleLabel.numberOfLines = 0;
    [_backView addSubview:_titleLabel];

    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = KFONT(11);
    _nameLabel.textColor =  KCOLOR_GRAY;
    [_backView addSubview:_nameLabel];
    
    _lastPostDateLabel = [[UILabel alloc] init];
    _lastPostDateLabel.font = KFONT(11);
    _lastPostDateLabel.textColor =  KCOLOR_GRAY;
    [_backView addSubview:_lastPostDateLabel];
    
    _commentLabel = [[UILabel alloc] init];
    [_backView addSubview:_commentLabel];
    _commentLabel.font = KFONT(11);
    _commentLabel.textColor =  KCOLOR_GRAY;
    
    _watchLabel = [[UILabel alloc] init];
    [_backView addSubview:_watchLabel];
    _watchLabel.font = KFONT(11);
    _watchLabel.textColor =  KCOLOR_GRAY;
}
- (void)setupConstrains {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.top.equalTo(_backView).offset(13);

    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(13);
        make.bottom.equalTo(_backView).offset(-13);
    }];


    [_lastPostDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_nameLabel);
        make.centerX.equalTo(_backView);
    }];
    
    UIImageView *watchImgView = [[UIImageView alloc] init];
    UIImage *watchImg = [UIImage imageNamed:@"forum-view"];
    [watchImgView setImage:watchImg];
    [_backView addSubview:watchImgView];
    [watchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.width.mas_equalTo(watchImg.size.width);
        make.height.mas_equalTo(watchImg.size.height);
        make.right.equalTo(_watchLabel.mas_left).offset(-2);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(watchImgView.mas_left).offset(-5);
        make.top.bottom.equalTo(_nameLabel);
    }];
    
    UIImageView *commentImgView = [[UIImageView alloc] init];
    UIImage *commentImg = [UIImage imageNamed:@"forum-comment"];
    [commentImgView setImage:commentImg];
    [_backView addSubview:commentImgView];
    [commentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.width.mas_equalTo(commentImg.size.width);
        make.height.mas_equalTo(commentImg.size.height);
        make.right.equalTo(_commentLabel.mas_left).offset(-2);
    }];

    _digestImgView = [[UIImageView alloc] init];
    [_backView addSubview:_digestImgView];
    [_digestImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_backView);
        make.width.height.mas_equalTo(30);
    }];

    UIImageView *clockImgView = [[UIImageView alloc] init];
    UIImage *clockImg = [UIImage imageNamed:@"forum-clock"];
    [clockImgView setImage:clockImg];
    [_backView addSubview:clockImgView];
    [clockImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.width.mas_equalTo(commentImg.size.width);
        make.height.mas_equalTo(commentImg.size.width);
        make.right.equalTo(_lastPostDateLabel.mas_left).offset(-2);
    }];
    
    [_watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel.mas_right);
        make.top.right.bottom.equalTo(_nameLabel);
    }];
}
- (void)loadData:(ArticleModel *)data andTypeName:(NSString *)typeName{
    NSString *titleStr;
    if (typeName) {
        titleStr = [NSString stringWithFormat:@"[%@] %@", typeName, data.title];
    } else {
        titleStr = data.title;
    }

    titleStr = [titleStr stringFromHTML];
    //add attributes
    NSMutableAttributedString *mutAttrTitleStr = [[NSMutableAttributedString alloc] initWithString: titleStr];
    if (typeName) {
        [mutAttrTitleStr addAttribute:NSForegroundColorAttributeName value:KCOLOR_BLUE_0066FF range:NSMakeRange(0, typeName.length + 2)];
        [mutAttrTitleStr addAttribute:NSForegroundColorAttributeName value:KCOLOR_RED_6D2C1D range:NSMakeRange(typeName.length + 2, titleStr.length - typeName.length - 2)];
        
    } else {
        [mutAttrTitleStr addAttribute:NSForegroundColorAttributeName value:KCOLOR_RED_6D2C1D range:NSMakeRange(0,  titleStr.length)];
    }
    //add attachment
    if ([data.attachmentNum intValue] != 0) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"forum-attachment"];
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [mutAttrTitleStr appendAttributedString:attrStringWithImage];
    }

    [_titleLabel setAttributedText:mutAttrTitleStr];

    _nameLabel.text = data.authorName;
    NSString *localLastPost = [data.lastPost toLocalTime];
    NSString *formattedLastPost = [localLastPost formatLastPost];
    _lastPostDateLabel.text = formattedLastPost;
    _commentLabel.text = data.replyNum;
    _watchLabel.text = data.viewNum;
    if ([data.digest intValue] != 0) {
        UIImage *digestImg = [UIImage imageNamed:@"forum-digest"];
        [_digestImgView setImage:digestImg];
    }
}

@end
