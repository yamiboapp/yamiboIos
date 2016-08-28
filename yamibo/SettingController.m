//
//  SettingController.m
//  yamibo
//
//  Created by shuang yang on 11/7/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "SettingController.h"
#import "AppManager.h"
#import "NKColorSwitch.h"
#import "ProfileManager.h"
#import "MenuController.h"

@interface SettingController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cells;
@property (strong, nonatomic) UILabel *cacheLabel;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initTableView];
    if ([[ProfileManager sharedInstance] checkLogin]) {
        [self initLogout];
    }
    _cells = [NSMutableArray array];
    [_cells addObject:[NSMutableArray array]];
    [_cells addObject:[NSMutableArray array]];
    for (int i = 0; i < 6; i++) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [_cells[0] addObject:cell];
    }
    for (int i = 0; i < 2; i++) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [_cells[1] addObject:cell];
    }
    
    //_cacheSize = [NSString stringWithFormat:@"%.2fM", [FilePathUtility folderSizeAtPath:[FilePathUtility cachesDirectory]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"设置";
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
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(400);
    }];
}
- (void)initLogout {
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCALE_NUM(266));
        make.height.mas_equalTo(SCALE_NUM(44));
        make.centerX.equalTo(self.view);
    }];
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = true;
    btn.backgroundColor = KCOLOR_RED_6D2C1D;
    [btn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}
- (void)logout {
    [Utility showTitle:@"已退出" hideAfter:0.5];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    NSDictionary *dic = @{kLeftDrawerSelectionIndexKey:@(CenterControllerHome)};
    [[NSNotificationCenter defaultCenter] postNotificationName:KChangeCenterViewNotification object:nil userInfo:dic];
}
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else {
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.section][indexPath.row];
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01f;
    } else {
        return 8.0f;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _cells[indexPath.section][indexPath.row] = cell;

    [cell setBackgroundColor:KCOLOR_YELLOW_FDF5D8];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    [cell addSubview:titleLabel];
    NSArray *titles = @[@[@"显示繁体", @"显示图片",@"夜间模式",@"发帖模式",@"非Wi-Fi网络提示",@"清除缓存"], @[@"版本",@"开发者"]];
    titleLabel.text = titles[indexPath.section][indexPath.row];
    titleLabel.font = KFONT(15);
    titleLabel.textColor = KCOLOR_RED_6D2C1D;
    //space line
    UIView *line = [[UIView alloc] init];
    [cell addSubview:line];
    line.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    //accessory
    UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
    [rightArrowImgView setImage:[UIImage imageNamed:@"arrow-right"]];
    
    NKColorSwitch *rightSwitch = [[NKColorSwitch alloc] initWithFrame:CGRectMake(0, 0, 55, 26)];
    rightSwitch.onTintColor = KCOLOR_RED_6D2C1D;
    rightSwitch.tintColor = KCOLOR_GRAY;
    rightSwitch.tag = indexPath.row;
    [rightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];

    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 49)];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.font = KFONT(15);
    rightLabel.textColor = KCOLOR_RED_6D2C1D;

    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: //显示繁体
                    if ([AppManager sharedInstance].isTradionChinese) {
                        rightSwitch.on = YES;
                    } else {
                        rightSwitch.on = NO;
                    }
                    cell.accessoryView = rightSwitch;
                    break;
                case 1: //显示图片
                    if (![AppManager sharedInstance].isNoImgMode) {
                        rightSwitch.on = YES;
                    } else {
                        rightSwitch.on = NO;
                    }
                    cell.accessoryView = rightSwitch;
                    break;
                case 2: //夜间模式
                    if ([AppManager sharedInstance].isNightMode) {
                        rightSwitch.on = YES;
                    } else {
                        rightSwitch.on = NO;
                    }
                    cell.accessoryView = rightSwitch;
                    break;
                case 3:
                    cell.accessoryView = rightArrowImgView;
                    break;
                case 4:
                    cell.accessoryView = rightSwitch;
                    break;
                case 5: //清除缓存
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    _cacheLabel = rightLabel;
                    _cacheLabel.text = [self getCacheSize];
                    cell.accessoryView = _cacheLabel;
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    rightLabel.text = @"1.0"; //TODO: version
                    cell.accessoryView = rightLabel;
                    break;
                case 1:
                    cell.accessoryView = rightArrowImgView;
                    break;
                default:
                    break;
            }
            break;
    }
    
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 5) {
        [self showActionSheete];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
- (void)switchValueChanged:(UISwitch *)sender {
    switch (sender.tag) {
        case 0: //显示繁体
            if (sender.isOn) {
                [AppManager sharedInstance].isTradionChinese = YES;
            } else {
                [AppManager sharedInstance].isTradionChinese = NO;
            }
            break;
        case 1: //显示图片
            if (sender.isOn) {
                [AppManager sharedInstance].isNoImgMode = NO;
            } else {
                [AppManager sharedInstance].isNoImgMode = YES;
            }
            break;
        case 2: //夜间模式
            if (sender.isOn) {
                [AppManager sharedInstance].isNightMode = YES;
            } else {
                [AppManager sharedInstance].isNightMode = NO;
            }
            break;
        case 4: //非wifi网络提示
            break;
        default:
            break;
    }
}

- (void)showActionSheete {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FilePathUtility clearCacheAtPath:[FilePathUtility cachesDirectory]];
        _cacheLabel.text = [self getCacheSize];
    }];
    [alert addAction:action];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:true completion:nil];
}

-(NSString *)getCacheSize {
    return [NSString stringWithFormat:@"%.2fM", [FilePathUtility folderSizeAtPath:[FilePathUtility cachesDirectory]]];
}

@end
