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
    UIImageView *rightArray = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
    [rightArray setImage:[UIImage imageNamed:@"accessory-more"]];
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
    [face setUserId:[ProfileManager sharedInstance].userId andType:FaceMiddle];
    face.layer.cornerRadius = SCALE_NUM(66)/2;
    face.clipsToBounds = true;
    face.backgroundColor = [UIColor yellowColor];
    
    if ([[ProfileManager sharedInstance] checkLogin]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(face.mas_bottom).offset(9);
            make.centerX.equalTo(face);
        }];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = KFONT(14);
        nameLabel.textColor = KCOLOR_YELLOW_FDF5D8;
        nameLabel.text = [ProfileManager sharedInstance].userName;
        
        UIImageView *genderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        UIImage *genderImg;
        int gender = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"] intValue];
        if (gender == 1) {
            genderImg = [UIImage imageNamed:@"gender-male"];
        } else if (gender == 2) {
            genderImg = [UIImage imageNamed:@"gender-female"];
        }
        [genderImgView setImage:genderImg];
        [self addSubview:genderImgView];
        [genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(8);
            make.centerY.equalTo(nameLabel);
        }];
        
        UILabel *idLabel = [[UILabel alloc] init];
        [self addSubview:idLabel];
        [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(10);
            make.centerX.equalTo(nameLabel);
        }];
        idLabel.font = KFONT(12);
        idLabel.textAlignment = NSTextAlignmentCenter;
        idLabel.textColor = KCOLOR_YELLOW_FDF5D8;
        idLabel.text = [NSString stringWithFormat:@"UID:%@", [ProfileManager sharedInstance].userId];
        
        UILabel *levelLabel = [[UILabel alloc] init];
        [self addSubview:levelLabel];
        [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(idLabel.mas_bottom).offset(8);
            make.centerX.equalTo(nameLabel);
        }];
        levelLabel.font = KFONT(12);
        levelLabel.textAlignment = NSTextAlignmentCenter;
        levelLabel.textColor = KCOLOR_YELLOW_FDF5D8;
        levelLabel.text = [ProfileManager sharedInstance].rank;
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        [self addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(levelLabel.mas_bottom).offset(9);
            make.centerX.equalTo(nameLabel);
        }];
        scoreLabel.font = KFONT(12);
        scoreLabel.textColor = KCOLOR_YELLOW_FDF5D8;
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.text = [NSString stringWithFormat:@"积分：%@", [ProfileManager sharedInstance].credit];
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
        //make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
        make.centerX.mas_equalTo(self).offset(-115);
    }];
    
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
    [_iconView setImage:icon];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(icon.size.width);
        make.height.mas_equalTo(icon.size.height);

    }];
}
@end
