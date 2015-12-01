//
//  ProfileControllerViewController.m
//  yamibo
//
//  Created by shuang yang on 11/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ProfileController.h"
#import "ProfileModel.h"
#import "CommunicationrManager.h"
#import "YFaceImageView.h"
#import "BlogListController.h"

@interface ProfileController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) ProfileModel *userData;
@property (assign, nonatomic) BOOL isMyProfile;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cells;
@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self getUserData];

    _cells = [NSMutableArray array];
    [_cells addObject:[[UITableViewCell alloc] init]]; //header
    [_cells addObject:[NSMutableArray array]]; //主题、回复、日志
    for (int i = 0; i < 3; i++) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [_cells[1] addObject:cell];
    }
    [_cells addObject:[[UITableViewCell alloc] init]]; //发送消息
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configNavigation {
    [self showCustomNavigationBackButton];
}

- (void)getUserData {
    [CommunicationrManager getProfileWithUid:_userId completion:^(ProfileModel *model, NSString *message) {
        _userData = model;
        _isMyProfile = [_userId isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
        if (_isMyProfile) {
            self.title = @"我的主页";
        } else {
            self.title = [NSString stringWithFormat:@"%@的主页", _userData.userName];
        }

        [self initTableView];
    }];
}
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //FIXME:make.edges.equalTo(self.view) not working as expected
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-35);
        make.left.right.bottom.equalTo(self.view);
    }];
}
- (void)loadDate:(NSString *)uid {
    _userId = uid;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isMyProfile) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 1;
        default:
            return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 97;
        case 1:
            return 49;
        case 2:
            return 52;
        default:
            return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return _cells[0];
        case 1:
            return _cells[1][indexPath.row];
        case 2:
            return _cells[2];
        default:
            return nil;
    }
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0.01f;
        case 1:
            return 8.0f;
        case 2:
            return 8.0f;
        default:
            return 0;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:KCOLOR_YELLOW_FDF5D8];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) { //header
        _cells[0] = cell;
        cell.userInteractionEnabled = NO;
        //avatar
        YFaceImageView *face = [[YFaceImageView alloc] init];
        [cell addSubview:face];
        [face setUserId:_userId andType:FaceMiddle];
        face.layer.cornerRadius = SCALE_NUM(66)/2;
        face.clipsToBounds = true;
        face.backgroundColor = [UIColor yellowColor];
        //name
        UILabel *nameLabel = [[UILabel alloc] init];
        [cell addSubview:nameLabel];
        nameLabel.font = KFONT(15);
        nameLabel.textColor = KCOLOR_RED_6D2C1D;
        nameLabel.text = _userData.userName;
        //gender
        UIImageView *genderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        UIImage *genderImg;
        int gender = [_userData.gender intValue];
        if (gender == 1) {
            genderImg = [UIImage imageNamed:@"gender-male"];
        } else if (gender == 2) {
            genderImg = [UIImage imageNamed:@"gender-female"];
        }
        [genderImgView setImage:genderImg];
        [cell addSubview:genderImgView];
        //user group
        UILabel *levelLabel = [[UILabel alloc] init];
        [cell addSubview:levelLabel];
        levelLabel.font = KFONT(12);
        levelLabel.textColor = [UIColor whiteColor];
        levelLabel.text = [_userData.rank stringFromHTML];
        levelLabel.textAlignment = NSTextAlignmentCenter;
        levelLabel.layer.cornerRadius = 6;
        levelLabel.layer.masksToBounds = YES;
        levelLabel.backgroundColor = KCOLOR_BLUE_0066FF;
        //uid
        UILabel *idLabel = [[UILabel alloc] init];
        [cell addSubview:idLabel];
        idLabel.font = KFONT(13);
        idLabel.textColor = KCOLOR_GRAY;
        idLabel.text = [NSString stringWithFormat:@"UID:%@", _userId];
        //user credit
        UILabel *scoreLabel = [[UILabel alloc] init];
        [cell addSubview:scoreLabel];
        scoreLabel.font = KFONT(13);
        scoreLabel.textColor = KCOLOR_GRAY;
        scoreLabel.text = [NSString stringWithFormat:@"积分：%@", _userData.credit];
        
        //constrains
        [face mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SCALE_NUM(66));
            make.centerY.equalTo(cell);
            make.left.equalTo(cell).offset(20);
        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(28);
            make.left.equalTo(face.mas_right).offset(20);
        }];
        [genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(4);
            make.centerY.equalTo(nameLabel);
        }];
        [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scoreLabel);
            make.left.greaterThanOrEqualTo(genderImgView.mas_right).offset(20);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(19);
            make.centerY.equalTo(nameLabel);
        }];
        [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.top.equalTo(nameLabel.mas_bottom).offset(10);
        }];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(idLabel.mas_right).offset(20);
            make.centerY.equalTo(idLabel);
        }];
    }
    else if (indexPath.section == 1) { //主题、回复、日志
        _cells[1][indexPath.row] = cell;
        //title
        UILabel *titleLabel = [[UILabel alloc] init];
        [cell addSubview:titleLabel];
        NSArray *titles = @[@"主题", @"回复",@"日志"];
        titleLabel.text = titles[indexPath.row];
        titleLabel.font = KFONT(15);
        titleLabel.textColor = KCOLOR_RED_6D2C1D;
        //space line
        UIView *line = [[UIView alloc] init];
        [cell addSubview:line];
        line.backgroundColor = KCOLOR_YELLOW_FFEDBE;
        //accessory
        UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
        [rightArrowImgView setImage:[UIImage imageNamed:@"arrow-right"]];
        cell.accessoryView = rightArrowImgView;
        
        //constrains
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell);
            make.left.equalTo(cell).offset(20);
            make.right.equalTo(cell).offset(-20);
            make.centerY.equalTo(cell);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(titleLabel);
            make.height.mas_equalTo(1);
        }];
    } else {
        _cells[2] = cell;
        UILabel *btnLabel = [[UILabel alloc] init];
        [cell addSubview:btnLabel];
        btnLabel.text = @"发送消息";
        btnLabel.font = KFONT(15);
        btnLabel.textColor = KCOLOR_RED_6D2C1D;
        btnLabel.textAlignment = NSTextAlignmentCenter;
        
        [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 2) { //日志
            BlogListController *blogController = [[BlogListController alloc] init];
            NSDictionary *dic = @{@"userId":_userId, @"userName":_userData.userName};
            [blogController loadDate:dic];
            [self.navigationController pushViewController:blogController animated:YES];
        }
    }
}

@end
