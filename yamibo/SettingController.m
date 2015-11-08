//
//  SettingController.m
//  yamibo
//
//  Created by shuang yang on 11/7/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "SettingController.h"

#define KSettingTableViewCell @"KSettingTableViewCell"
@interface SettingController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cells;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"设置";
}

- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KSettingTableViewCell];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _cells[indexPath.section][indexPath.row] = cell;

    [cell setBackgroundColor:KCOLOR_YELLOW_FDF5D8];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    [cell addSubview:titleLabel];
    NSArray *titles = @[@[@"显示头像",@"显示图片",@"夜间模式",@"发帖模式",@"非Wi-Fi网络提示",@"清除缓存"], @[@"版本",@"开发者"]];
    titleLabel.text = titles[indexPath.section][indexPath.row];
    titleLabel.font = KFONT(15);
    titleLabel.textColor = KCOLOR_RED_6D2C1D;
    //space line
    UIView *line = [[UIView alloc] init];
    [cell addSubview:line];
    line.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    //accessory
    UIImageView *rightArray = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 13)];
    [rightArray setImage:[UIImage imageNamed:@"accessory-more"]];

    UISwitch *rightSwitch = [UISwitch new];
    rightSwitch.onTintColor = KCOLOR_RED_6D2C1D;
    rightSwitch.tintColor = [UIColor clearColor];
    rightSwitch.backgroundColor = KCOLOR_GRAY;
    rightSwitch.layer.cornerRadius = 16.0;
    rightSwitch.tag = indexPath.row;
    [rightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.font = KFONT(15);
    rightLabel.textColor = KCOLOR_RED_6D2C1D;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                case 1:
                case 2:
                case 4:
                    cell.accessoryView = rightSwitch;
                    break;
                case 3:
                    cell.accessoryView = rightArray;
                    break;
                case 5:
                    rightLabel.text = @"3.14M"; //TODO: cache
                    cell.accessoryView = rightLabel;
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
                    cell.accessoryView = rightArray;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.section][indexPath.row];
}

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

- (void)switchValueChanged:(UISwitch *)sender {
    switch (sender.tag) {
        case 0:
            //TODO
            break;
            
        default:
            break;
    }
}
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
@end
