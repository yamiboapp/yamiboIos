//
//  MenuTableViewCell.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "YFaceImageView.h"
#import "ProfileManager.h"

@interface MenuTableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *iconView;

@end

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if ([reuseIdentifier isEqualToString:KMenuTableHeadCell]) {
            [self initHeadView];
        } else {
            [self initIconItem];
            [self initAccessory];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initAccessory {
    UIView *rightArray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 15)];
    rightArray.backgroundColor = [UIColor redColor];
    self.accessoryView = rightArray;
    
}
- (void)initHeadView {
    self.backgroundColor = KCOLOR_RED_6D2C1D;
    YFaceImageView *face = [[YFaceImageView alloc] init];
    [self addSubview:face];
    [face mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(66));
        make.top.mas_equalTo(SCALE_NUM(45));
        make.centerX.equalTo(self);
    }];
    [face setUserId:[ProfileManager sharedInstance].userId pic:[ProfileManager sharedInstance].avaturl];
    face.layer.cornerRadius = SCALE_NUM(66)/2;
    face.clipsToBounds = true;
    face.backgroundColor = [UIColor yellowColor];
    
    if ([[ProfileManager sharedInstance] checkLogin]) {
        
    } else {
        UILabel *loginLabel = [[UILabel alloc] init];
        [self addSubview:loginLabel];
        [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(face);
            make.top.equalTo(face.mas_bottom).offset(SCALE_NUM(34));
            make.height.mas_equalTo(SCALE_NUM(30));
        }];
        loginLabel.layer.cornerRadius = 5;
        loginLabel.clipsToBounds = true;
        loginLabel.textColor = KCOLOR_YELLOW_FDF5D8;
        loginLabel.textAlignment = NSTextAlignmentCenter;
        loginLabel.text = @"点击登陆";
        loginLabel.font = KFONT(10);
        loginLabel.backgroundColor = KCOLOR_RED_A1422C;
    }
}
- (void)initIconItem {
    self.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    _iconView = [[UIImageView alloc] init];
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
    }];
    _iconView.backgroundColor = [UIColor redColor];
    
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.top.bottom.equalTo(self);
    }];
    _titleLabel.font = KFONT(14);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
}
- (void)loadTitle:(NSString *)title andIcon:(UIImage *)icon {
    _titleLabel.text = title;
}
@end
