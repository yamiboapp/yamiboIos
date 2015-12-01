//
//  BlogListTableViewCell.m
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BlogListTableViewCell.h"
#import "BlogModel.h"

@interface BlogListTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation BlogListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        [self initBack];
        [self initContent];
    }
    return self;
}
- (void)configCell {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)initBack {
    _backView = [[UIView alloc] init];
    [self.contentView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    _backView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
}
- (void)initContent {
    _titleLabel = [[UILabel alloc] init];
    [_backView addSubview:_titleLabel];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = KFONT(15);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
    
    _timeLabel = [[UILabel alloc] init];
    [_backView addSubview:_timeLabel];
    _timeLabel.font = KFONT(10);
    _timeLabel.textColor = KCOLOR_GRAY;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.right.equalTo(_timeLabel.mas_left);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-23);
        make.width.mas_equalTo(80);
        make.top.equalTo(_titleLabel);
    }];
}
- (void)loadData:(BlogModel *)data {
    _titleLabel.text = [data.title stringFromHTML];
    _timeLabel.text = data.date;
}
@end
