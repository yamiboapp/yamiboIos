//
//  BaseViewController.m
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
@interface BaseViewController () {
}

@end

@implementation BaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = true;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)showMessage:(NSString*)message;
{
    UILabel* tLabelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 38)];
    tLabelTip.text = message;
    tLabelTip.font = [UIFont systemFontOfSize:15];
    tLabelTip.backgroundColor = [UIColor clearColor];
    tLabelTip.textColor = [UIColor whiteColor];
    tLabelTip.lineBreakMode = NSLineBreakByWordWrapping;
    tLabelTip.textAlignment = NSTextAlignmentCenter;
    tLabelTip.numberOfLines = 2;
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.customView = tLabelTip;
    hud.mode = MBProgressHUDModeCustomView;

    CGSize SimpleTextSize = [tLabelTip contentSize];
    if (SimpleTextSize.width > 194) {
        tLabelTip.textAlignment = NSTextAlignmentLeft;
    }
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

#pragma mark Hide/Show StatusBar
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
