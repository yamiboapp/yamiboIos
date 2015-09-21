//
//  PrivateMessageTableViewCell.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "PrivateMessageTableViewCell.h"
#import "YFaceImageView.h"

@interface PrivateMessageTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) YFaceImageView *headImg;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UIImageView *genderTint;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation PrivateMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        [self initBack];
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

@end
