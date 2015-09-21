//
//  MessageController.m
//  yamibo
//
//  Created by shuang yang on 9/21/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageController.h"
#import "PrivateMessageTableView.h"
#import "PublicMessageTableView.h"

@interface MessageController ()
@property (strong, nonatomic)   PrivateMessageTableView *PrivateMessageView;
@property (strong, nonatomic)   PublicMessageTableView *PublicMessageView;
@end

@implementation MessageController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initSwitch];

}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"消息";
}
- (void)initSwitch {

    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"公共信息", @"私人信息"]];
    UIView *back = [[UIView alloc]init];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        //make.bottom.equalTo(self).offset(-1);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(43);
    }];
    back.backgroundColor = KCOLOR_YELLOW_FDF5D8;

    [back addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    segment.tintColor = [UIColor clearColor];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     KCOLOR_RED_6D2C1D, NSForegroundColorAttributeName,
                                     KFONT(15), NSFontAttributeName,
                                     KCOLOR_RED_6D2C1D, NSUnderlineColorAttributeName,
                                     
                                     nil]
                           forState:UIControlStateSelected];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     KCOLOR_GRAY, NSForegroundColorAttributeName,
                                     KFONT(15), NSFontAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    segment.selectedSegmentIndex = 1;
    //[segment setWidth:SCALE_NUM(120)];
    //[segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
}
- (void)onNavigationLeftButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}

@end
