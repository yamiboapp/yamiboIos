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
@property (strong, nonatomic) UILabel *lastPostLabel;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UILabel *watchLabel;
@property (assign, nonatomic) NSString *digestImgName;
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
    _backView.normalBackgroundColor = KCOLOR_YELLOW_FDF5D8;
    _backView.nightBackgroundColor = UIColorFromRGB(0x343434);

    [self.contentView addSubview:_backView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = KFONT(15);
    _titleLabel.normalTextColor = KCOLOR_RED_6D2C1D;
    _titleLabel.nightTextColor = [UIColor whiteColor];
    _titleLabel.numberOfLines = 0;
    [_backView addSubview:_titleLabel];

    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = KFONT(11);
    _nameLabel.normalTextColor = KCOLOR_GRAY;
    _nameLabel.nightTextColor = [UIColor whiteColor];
    [_backView addSubview:_nameLabel];
    
    _lastPostLabel = [[UILabel alloc] init];
    _lastPostLabel.font = KFONT(11);
    _lastPostLabel.normalTextColor = KCOLOR_GRAY;
    _lastPostLabel.nightTextColor = [UIColor whiteColor];
    [_backView addSubview:_lastPostLabel];
    
    _commentLabel = [[UILabel alloc] init];
    [_backView addSubview:_commentLabel];
    _commentLabel.font = KFONT(9);
    _commentLabel.normalTextColor = KCOLOR_GRAY;
    _commentLabel.nightTextColor = [UIColor whiteColor];
    
    _watchLabel = [[UILabel alloc] init];
    [_backView addSubview:_watchLabel];
    _watchLabel.font = KFONT(11);
    _watchLabel.normalTextColor = KCOLOR_GRAY;
    _watchLabel.nightTextColor = [UIColor whiteColor];
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

    [_lastPostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_nameLabel);
        make.left.equalTo(_backView.mas_left).offset(130);
    }];
    
    [_watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel.mas_right);
        make.top.right.bottom.equalTo(_nameLabel);
    }];
    
    UIImageView *watchImgView = [[UIImageView alloc] init];
    UIImage *watchImg = [UIImage imageNamed:@"forum-view"];
    [watchImgView setImage:watchImg];
    [_backView addSubview:watchImgView];
    [watchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_nameLabel);
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
        make.top.bottom.equalTo(_nameLabel);
        make.width.mas_equalTo(commentImg.size.width);
        make.height.mas_equalTo(commentImg.size.height);
        make.right.equalTo(_commentLabel.mas_left).offset(-2);
    }];

    UIImageView *digestImgView = [[UIImageView alloc] init];
    UIImage *digestImg = [UIImage imageNamed:_digestImgName];
    [digestImgView setImage:digestImg];
    [_backView addSubview:digestImgView];
    [digestImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_backView);
        make.width.mas_equalTo(digestImg.size.width);
        make.height.mas_equalTo(digestImg.size.height);
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
    _lastPostLabel.text = [NSString stringWithFormat:@"最新回复：%@", formattedLastPost];
    _commentLabel.text = data.replyNum;
    _watchLabel.text = data.viewNum;
    if ([data.isDigest intValue] == 1) {
        _digestImgName = @"forum-digest";
    } else {
        _digestImgName = @"";
    }
}

@end
